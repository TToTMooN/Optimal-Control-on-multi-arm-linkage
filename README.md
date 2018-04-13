## Optimal-Control-on-multi-arm-linkage
### Table of Contents
1. [Overview](#overview)
2. [Arm linkage system modelling](#modelling)
3. [Optimal Control Design](#control-design)


### Overview <a name="overview"></a>

The purpose of this project is to test how optimal control methods can work in nonlinear systems.

### Arm linkage system modelling <a name="modelling"></a>

#### Single arm system

To start with, we first start with a single arm system. The physics for this is simple, but this is a simple way to test if the controller is working.
#### Two-arm system
Things becomes more difficult when more arms are introduced. The equation of motion is complex since centrifugal and Coriolis force are playing an important role. We will introduce a general way to generate the eom in later section. But now, we are using Lagrangian mechanics to solve this system.
#### General method of for multi-arm system
We will use projected Newton Euler Equation to solve for eom of multi-arm system.

### Optimal Control Design <a name="control-design"></a>
