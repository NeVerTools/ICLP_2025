#!/bin/bash

# Delete all data
rm -rf Generators/Data/labels/Binary\ Linear/*
rm -rf Generators/Data/labels/Binary\ Deep/*
rm -rf Generators/Data/labels/Multi\ Linear/*
rm -rf Generators/Data/labels/Multi\ Deep/*

rm -rf Generators/Data/points/Binary\ Linear/*
rm -rf Generators/Data/points/Binary\ Deep/*
rm -rf Generators/Data/points/Multi\ Linear/*
rm -rf Generators/Data/points/Multi\ Deep/*

rm -rf Generators/Data/weights/Binary\ Linear/*
rm -rf Generators/Data/weights/Binary\ Deep/*
rm -rf Generators/Data/weights/Multi\ Linear/*
rm -rf Generators/Data/weights/Multi\ Deep/*

rm -rf Experiments/Networks/*
rm -rf Experiments/Properties/*
rm -rf Experiments/Vulnerability/*

rm -rf Experiments/instances_*