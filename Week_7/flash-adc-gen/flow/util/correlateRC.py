#!/usr/bin/env python3

# Read grt/rcx capacitance/wire length files for multiple designs and
# use linear regression to fit layer capacitances to rcx net capacitances.
# Use ORFS 'make write_net_rc' to write cap files.

import os
from sys import exit
from collections import defaultdict

import collections
import argparse
import re
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# Parse and validate arguments
# =============================================================================


def parse_args():
    parser = argparse.ArgumentParser(
        description="Determines layer capacitance and resistance values for OpenROAD flow designs"
    )
    parser.add_argument(
        "-cap_unit", required=False, default="pf", help="capacitance unit ff|pf"
    )
    parser.add_argument(
        "-res_unit", required=False, default="kohm", help="resistance unit ohm|kohm"
    )
    parser.add_argument(
        "-plot_cap",
        required=False,
        action="store_true",
        default=False,
        help="Plot grt/rcx capacitance differences",
    )
    parser.add_argument(
        "-plot_res",
        required=False,
        action="store_true",
        default=False,
        help="Plot grt/rcx resistance differences",
    )
    parser.add_argument(
        "rc_file", nargs="+", help="rc csv file written by make compare_rc"
    )
    args = parser.parse_args()

    return args


args = parse_args()

# kohm/ff nangate45, asap7
# kohm/pf sky130hd, sky130hs

res_unit = args.res_unit
if res_unit == "ohm":
    res_scale = 1
elif res_unit == "kohm":
    res_scale = 1e3
else:
    print("unknown resistance unit")
    exit

cap_unit = args.cap_unit
if cap_unit == "ff":
    cap_scale = 1e-15
elif cap_unit == "pf":
    cap_scale = 1e-12
else:
    print("unknown capacitance unit")
    exit


def makeDict():
    return collections.defaultdict(makeDict)


data = makeDict()

# Parse the cap CSV file generated by compare_rc_script.tcl
for rc_file in args.rc_file:
    design = rc_file
    print("reading", design)
    with open(rc_file) as f:
        nonGrtNets = 0
        for line in f:
            tokens = line.strip().split(",")
            netName = tokens[0]
            gpl_res = float(tokens[1])
            gpl_cap = float(tokens[2])
            grt_res = float(tokens[3])
            grt_cap = float(tokens[4])
            rcx_res = float(tokens[5])
            rcx_cap = float(tokens[6])

            data[design][netName]["gpl_res"] = gpl_res
            data[design][netName]["gpl_cap"] = gpl_cap
            data[design][netName]["grt_res"] = grt_res
            data[design][netName]["grt_cap"] = grt_cap
            data[design][netName]["rcx_res"] = rcx_res
            data[design][netName]["rcx_cap"] = rcx_cap

            layer_lengths = []
            layer_names = []
            wire_length = 0.0
            for i in range(7, len(tokens), 2):
                layer_names.append(tokens[i])
                layer_length = float(tokens[i + 1])
                layer_lengths.append(layer_length)
                wire_length += layer_length
            data[design][netName]["layer_lengths"] = layer_lengths
            data[design][netName]["wire_length"] = wire_length

################################################################

if args.plot_cap:
    # Compare the GRT cap estimate vs. OpenRCX SPEF cap

    diff_x = []
    diff_percent_x = []
    for design in data:
        for net in data[design]:
            grt_cap = data[design][net]["grt_cap"]
            rcx_cap = data[design][net]["rcx_cap"]
            diff = grt_cap - rcx_cap
            if abs(diff) > 1e-12:
                print("large discrapancy:", design, net, diff)
            if rcx_cap != 0.0:
                normDiff = (diff / rcx_cap) * 100
                diff_x.append(diff / cap_scale)
                diff_percent_x.append(normDiff)

    # Generate histograms
    num_bins = 200
    fig = plt.figure()
    fig.suptitle("Difference between GRT est. Cap and RCX Cap")
    plt.subplot(2, 2, 1)
    plt.hist(diff_x, num_bins, facecolor="blue", alpha=0.5)
    plt.ylabel("# Nets")
    plt.xlabel(
        "Capacitance ({})\n\nMean: {:.3f}{}\nStd. dev: {:.3f}fF".format(
            cap_unit, np.mean(diff_x), cap_unit, np.std(diff_x)
        )
    )

    plt.subplot(2, 2, 2)
    plt.hist(diff_percent_x, num_bins, range={-1000, 1000}, facecolor="blue", alpha=0.5)
    plt.ylabel("# Nets")
    plt.xlabel(
        "%\n\nMean: {:.3f}%\nStd. dev: {:.3f}%".format(
            np.mean(diff_percent_x), np.std(diff_percent_x)
        )
    )
    plt.show()

################################################################

if args.plot_res:
    # Compare the GRT res estimate vs. OpenRCX SPEF res

    diff_x = []
    diff_percent_x = []
    for design in data:
        for net in data[design]:
            grt_res = data[design][net]["grt_res"]
            rcx_res = data[design][net]["rcx_res"]
            if grt_res > 0 and rcx_res > 0:
                diff = grt_res - rcx_res
                if abs(diff) > 1e3:
                    print("large discrapancy:", design, net, diff)
                if rcx_res != 0.0:
                    normDiff = (diff / rcx_res) * 100
                    diff_x.append(diff / res_scale)
                    diff_percent_x.append(normDiff)

    # Generate histograms
    num_bins = 200
    fig = plt.figure()
    fig.suptitle("Difference between GRT est. Res and RCX Res")
    plt.subplot(2, 2, 1)
    plt.hist(diff_x, num_bins, facecolor="blue", alpha=0.5)
    plt.ylabel("# Nets")
    plt.xlabel(
        "Resacitance ({})\n\nMean: {:.3f}{}\nStd. dev: {:.3f}fF".format(
            res_unit, np.mean(diff_x), res_unit, np.std(diff_x)
        )
    )

    plt.subplot(2, 2, 2)
    plt.hist(diff_percent_x, num_bins, range={-1000, 1000}, facecolor="blue", alpha=0.5)
    plt.ylabel("# Nets")
    plt.xlabel(
        "%\n\nMean: {:.3f}%\nStd. dev: {:.3f}%".format(
            np.mean(diff_percent_x), np.std(diff_percent_x)
        )
    )
    plt.show()

################################################################

# Use linear regression to find updated layer resistances.

x = []
y = []
for design in data:
    for net in data[design]:
        rcx_res = data[design][net]["rcx_res"]
        if rcx_res > 0:
            layer_lengths = data[design][net]["layer_lengths"]
            x.append(layer_lengths)
            y.append(rcx_res)

x = np.array(x)
y = np.array(y)

res_model = LinearRegression(fit_intercept=False).fit(x, y)
r_sq = res_model.score(x, y)
print("Resistance coefficient of determination: {:.4f}".format(r_sq))

################################################################

# Use linear regression to find updated layer capacitances.

x = []
y = []
for design in data:
    for net in data[design]:
        layer_lengths = data[design][net]["layer_lengths"]
        x.append(layer_lengths)
        y.append(data[design][net]["rcx_cap"])

x = np.array(x)
y = np.array(y)

cap_model = LinearRegression(fit_intercept=False).fit(x, y)
r_sq = cap_model.score(x, y)
print("Capacitance coefficient of determination: {:.4f}".format(r_sq))

print("Updated layer resistance {}/um capacitance {}/um".format(res_unit, cap_unit))
for layer, res_coeff, cap_coeff in zip(layer_names, res_model.coef_, cap_model.coef_):
    if res_coeff > 0.0 or cap_coeff > 0.0:
        print(
            "set_layer_rc -layer {} -resistance {:.5E} -capacitance {:.5E}".format(
                layer, res_coeff / res_scale, cap_coeff / cap_scale
            )
        )

################################################################

x = []
y = []
for design in data:
    for net in data[design]:
        wire_res = data[design][net]["rcx_res"]
        wire_length = data[design][net]["wire_length"]
        if wire_res != 0.0:
            x.append([wire_length])
            y.append(wire_res)

x = np.array(x)
y = np.array(y)

wire_res_model = LinearRegression(fit_intercept=False).fit(x, y)
wire_res = wire_res_model.coef_[0]

x = []
y = []
for design in data:
    for net in data[design]:
        wire_length = data[design][net]["wire_length"]
        x.append([wire_length])
        y.append(data[design][net]["rcx_cap"])

x = np.array(x)
y = np.array(y)

wire_cap_model = LinearRegression(fit_intercept=False).fit(x, y)
wire_cap = wire_cap_model.coef_[0]

print(
    "set_wire_rc -resistance {:.5E} -capacitance {:.5E}".format(
        wire_res / res_scale, wire_cap / cap_scale
    )
)
