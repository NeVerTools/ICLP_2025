#!/bin/bash

# Delete all data
rm -rf Generators/Data/labels/Binary_L/*
rm -rf Generators/Data/labels/Binary_NL/*
rm -rf Generators/Data/labels/Multi_L/*
rm -rf Generators/Data/labels/Multi_NL/*

rm -rf Generators/Data/points/Binary_L/*
rm -rf Generators/Data/points/Binary_NL/*
rm -rf Generators/Data/points/Multi_L/*
rm -rf Generators/Data/points/Multi_NL/*

rm -rf Generators/Data/weights/Binary_L/*
rm -rf Generators/Data/weights/Binary_NL/*
rm -rf Generators/Data/weights/Multi_L/*
rm -rf Generators/Data/weights/Multi_NL/*

rm -rf Experiments/Networks/*
rm -rf Experiments/Properties/*
rm -rf Experiments/Vulnerability/*

rm -rf Experiments/instances_*