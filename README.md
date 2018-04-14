[//]: # (comment like this)

<!---
![Add figure here](https://github.com/TToTMooN/Optimal-Control-on-multi-arm-linkage/blob/master/figures/testFigure.jpeg)
--->

<!---
Add LaTeX by using https://www.codecogs.com/latex/eqneditor.php
--->

# Optimal-Control-on-multi-arm-linkage

- [Optimal-Control-on-multi-arm-linkage](#optimal-control-on-multi-arm-linkage)
    - [Overview](#overview)
    - [Arm linkage system modelling](#arm-linkage-system-modelling)
        - [Single arm system](#single-arm-system)
        - [Two-arm system](#two-arm-system)
        - [General method of for multi-arm system](#general-method-of-for-multi-arm-system)
    - [Optimal Control Design](#optimal-control-design)

## Overview

The purpose of this project is to test how optimal control methods can work in nonlinear systems.



## Arm linkage system modelling

### Single arm system

To start with, we first start with a single arm system. The physics for this is simple, but this is a simple way to test if the controller is working.

Assume each arm has a mass of **m**, length of **2L**, and an inertia of **j** with respect to its center of gravity. A torch input **&tau;** is used to control the arm angle **&theta;**, as shown in the figure below.

![single-arm](figures/single-arm.jpeg)

### Two-arm system

Things becomes more difficult when more arms are introduced. The equation of motion is complex since centrifugal and Coriolis force are playing an important role. We will introduce a general way to generate the eom in later section. But now, we are using Lagrangian mechanics to solve this system.

### General method of for multi-arm system

We will use projected Newton Euler Equation to solve for eom of multi-arm system.

## Optimal Control Design
