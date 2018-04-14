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

The purpose of this project is to test how optimal control methods can work in nonlinear systems. Suppose we have a multi-arm system, and we want to control the 



## Arm linkage system modelling

### Single arm system

To start with, we first start with a single arm system. The physics for this is simple, but this is a simple way to test if the controller is working.

Assume each arm has a mass of **m**, length of **2L**, and an inertia of **j** with respect to its center of gravity. A torch input **&tau;** is used to control the arm angle **&theta;**, as shown in the figure below.

![single-arm](figures/single-arm.jpg)

Since only torque, gravity of arm are considered in the motion equation, the equation of motion for this single-input-single-output(SISO) system is quite simple:

<a href="https://www.codecogs.com/eqnedit.php?latex=\ddot{\theta_1}=\frac{3}{4ml^2}(\tau&space;-&space;mg\cos{\theta_1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\ddot{\theta_1}=\frac{3}{4ml^2}(\tau&space;-&space;mg\cos{\theta_1})" title="\ddot{\theta_1}=\frac{3}{4ml^2}(\tau - mg\cos{\theta_1})" /></a>

### Two-arm system

Things becomes more difficult when more arms are introduced. The equation of motion is complex since centrifugal and Coriolis force are playing an important role. We will introduce a general way to generate the eom in later section. But now, we are using Lagrangian mechanics to solve this system.

![double-arm](figures/double-arm.jpg)

As seen in the figure, we define the end effector of first and second arm as (x1, y1) and (x2,y2). Therefore, we can get:
<a href="https://www.codecogs.com/eqnedit.php?latex=x_1=2l_1\cos{\theta_1},&space;y_1=2l_1\sin{\theta_1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_1=2l_1\cos{\theta_1},&space;y_1=2l_1\sin{\theta_1}" title="x_1=2l_1\cos{\theta_1}, y_1=2l_1\sin{\theta_1}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=x_2=2l_1\cos{\theta_1}&plus;2l_2\cos(\theta_1&plus;\theta_2),&space;y_2=2l_1\sin{\theta_1}&plus;2l_2\sin(\theta_1&plus;\theta_2)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_2=2l_1\cos{\theta_1}&plus;2l_2\cos(\theta_1&plus;\theta_2),&space;y_2=2l_1\sin{\theta_1}&plus;2l_2\sin(\theta_1&plus;\theta_2)" title="x_2=2l_1\cos{\theta_1}+2l_2\cos(\theta_1+\theta_2), y_2=2l_1\sin{\theta_1}+2l_2\sin(\theta_1+\theta_2)" /></a>

which can be used to calculate corresponding &theta; based on x using inverse kinematics.

For the equation of motion, we have kinetic energy of system:

<a href="https://www.codecogs.com/eqnedit.php?latex=KE=1/2&space;m_1&space;V_1^2&space;&plus;&space;1/2&space;j_1&space;\omega_1^2&space;&plus;&space;1/2&space;m_2&space;V_2^2&space;&plus;&space;1/2&space;j_2&space;\omega_2^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?KE=1/2&space;m_1&space;V_1^2&space;&plus;&space;1/2&space;j_1&space;\omega_1^2&space;&plus;&space;1/2&space;m_2&space;V_2^2&space;&plus;&space;1/2&space;j_2&space;\omega_2^2" title="KE=1/2 m_1 V_1^2 + 1/2 j_1 \omega_1^2 + 1/2 m_2 V_2^2 + 1/2 j_2 \omega_2^2" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=V_1&space;=&space;l_1\dot{\theta_1},&space;\omega_1=\dot{\theta_1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?V_1&space;=&space;l_1\dot{\theta_1},&space;\omega_1=\dot{\theta_1}" title="V_1 = l_1\dot{\theta_1}, \omega_1=\dot{\theta_1}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=V_{2x}=-2l_1\dot{\theta_1}\sin\theta_1-l_2(\dot{\theta_1}&plus;\dot{\theta_2})\sin(\theta_1&plus;\theta_2)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?V_{2x}=-2l_1\dot{\theta_1}\sin\theta_1-l_2(\dot{\theta_1}&plus;\dot{\theta_2})\sin(\theta_1&plus;\theta_2)" title="V_{2x}=-2l_1\dot{\theta_1}\sin\theta_1-l_2(\dot{\theta_1}+\dot{\theta_2})\sin(\theta_1+\theta_2)" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=V_{2y}=(2l_1\dot{\theta_1}\cos\theta_1&plus;l_2(\dot{\theta_1}&plus;\dot{\theta_2})\cos(\theta_1&plus;\theta_2))\mathbf{j}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?V_{2y}=(2l_1\dot{\theta_1}\cos\theta_1&plus;l_2(\dot{\theta_1}&plus;\dot{\theta_2})\cos(\theta_1&plus;\theta_2))\mathbf{j}" title="V_{2y}=(2l_1\dot{\theta_1}\cos\theta_1+l_2(\dot{\theta_1}+\dot{\theta_2})\cos(\theta_1+\theta_2))\mathbf{j}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\omega_2=\dot{\theta_1}&plus;\dot{\theta_2}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\omega_2=\dot{\theta_1}&plus;\dot{\theta_2}" title="\omega_2=\dot{\theta_1}+\dot{\theta_2}" /></a>

On the other hand, we have potential energy of system

<a href="https://www.codecogs.com/eqnedit.php?latex=PE=m_1gl_1\sin\theta_1&plus;m_2g(2l_1\sin\theta_1&plus;l_2\sin(\theta_1&plus;\theta_2))" target="_blank"><img src="https://latex.codecogs.com/gif.latex?PE=m_1gl_1\sin\theta_1&plus;m_2g(2l_1\sin\theta_1&plus;l_2\sin(\theta_1&plus;\theta_2))" title="PE=m_1gl_1\sin\theta_1+m_2g(2l_1\sin\theta_1+l_2\sin(\theta_1+\theta_2))" /></a>

We get the Lagrangian L=KE-PE as:

<a href="https://www.codecogs.com/eqnedit.php?latex=L=\frac{1}{2}m_1l_1^2\dot{\theta_1}^2&plus;\frac{1}{2}j_1\dot{\theta_1}^2\\&space;&plus;\frac{1}{2}m_2(4l_1^2\dot{\theta_1}^2&plus;l_2^2(\dot{\theta_1}^2&plus;\dot{\theta_2}^2)&plus;4l_1l_2\cos\theta_2\dot{\theta_1}(\dot{\theta_1}&plus;\dot{\theta_2}))\\&space;&plus;\frac{1}{2}j_2(\dot{\theta_1}&plus;\dot{\theta_2})^2-m_1gl_1\sin\theta_1-2m_2gl_1\sin\theta_1-m_2gl_2\sin(\theta_1&plus;\theta_2))" target="_blank"><img src="https://latex.codecogs.com/gif.latex?L=\frac{1}{2}m_1l_1^2\dot{\theta_1}^2&plus;\frac{1}{2}j_1\dot{\theta_1}^2\\&space;&plus;\frac{1}{2}m_2(4l_1^2\dot{\theta_1}^2&plus;l_2^2(\dot{\theta_1}^2&plus;\dot{\theta_2}^2)&plus;4l_1l_2\cos\theta_2\dot{\theta_1}(\dot{\theta_1}&plus;\dot{\theta_2}))\\&space;&plus;\frac{1}{2}j_2(\dot{\theta_1}&plus;\dot{\theta_2})^2-m_1gl_1\sin\theta_1-2m_2gl_1\sin\theta_1-m_2gl_2\sin(\theta_1&plus;\theta_2))" title="L=\frac{1}{2}m_1l_1^2\dot{\theta_1}^2+\frac{1}{2}j_1\dot{\theta_1}^2\\ +\frac{1}{2}m_2(4l_1^2\dot{\theta_1}^2+l_2^2(\dot{\theta_1}^2+\dot{\theta_2}^2)+4l_1l_2\cos\theta_2\dot{\theta_1}(\dot{\theta_1}+\dot{\theta_2}))\\ +\frac{1}{2}j_2(\dot{\theta_1}+\dot{\theta_2})^2-m_1gl_1\sin\theta_1-2m_2gl_1\sin\theta_1-m_2gl_2\sin(\theta_1+\theta_2))" /></a>

Using Lagrangian mechanics, we have:

<a href="https://www.codecogs.com/eqnedit.php?latex=$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial&space;L}{\partial&space;\dot{\theta_1}})-\frac{\partial&space;L}{\partial&space;\theta_1}=\tau_1$$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial&space;L}{\partial&space;\dot{\theta_1}})-\frac{\partial&space;L}{\partial&space;\theta_1}=\tau_1$$" title="$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial L}{\partial \dot{\theta_1}})-\frac{\partial L}{\partial \theta_1}=\tau_1$$" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial&space;L}{\partial&space;\dot{\theta_2}})-\frac{\partial&space;L}{\partial&space;\theta_2}=\tau_2$$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial&space;L}{\partial&space;\dot{\theta_2}})-\frac{\partial&space;L}{\partial&space;\theta_2}=\tau_2$$" title="$$\frac{\mathrm{d}}{\mathrm{dt}}(\frac{\partial L}{\partial \dot{\theta_2}})-\frac{\partial L}{\partial \theta_2}=\tau_2$$" /></a>

Simplify this equation, we can get the form of this equation of motion to be:

<a href="https://www.codecogs.com/eqnedit.php?latex=\underbar&space;u=&space;\begin{bmatrix}&space;\tau_1\\&space;\tau_2&space;\end{bmatrix}&space;=&space;\begin{bmatrix}&space;H_{11}&space;&&space;H_{12}&space;\\&space;H_{21}&space;&&space;H_{22}&space;\end{bmatrix}&space;\begin{bmatrix}&space;\ddot{\theta_1}\\&space;\ddot{\theta_2}&space;\end{bmatrix}&space;&plus;&space;\begin{bmatrix}&space;h\dot{\theta_2}^2&plus;2h\dot{\theta_1}\dot{\theta_2}\\&space;h\dot{\theta_1}\dot{\theta_2}&space;\end{bmatrix}&space;&plus;&space;\begin{bmatrix}&space;G_1\\&space;G_2&space;\end{bmatrix}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\underbar&space;u=&space;\begin{bmatrix}&space;\tau_1\\&space;\tau_2&space;\end{bmatrix}&space;=&space;\begin{bmatrix}&space;H_{11}&space;&&space;H_{12}&space;\\&space;H_{21}&space;&&space;H_{22}&space;\end{bmatrix}&space;\begin{bmatrix}&space;\ddot{\theta_1}\\&space;\ddot{\theta_2}&space;\end{bmatrix}&space;&plus;&space;\begin{bmatrix}&space;h\dot{\theta_2}^2&plus;2h\dot{\theta_1}\dot{\theta_2}\\&space;h\dot{\theta_1}\dot{\theta_2}&space;\end{bmatrix}&space;&plus;&space;\begin{bmatrix}&space;G_1\\&space;G_2&space;\end{bmatrix}" title="\underbar u= \begin{bmatrix} \tau_1\\ \tau_2 \end{bmatrix} = \begin{bmatrix} H_{11} & H_{12} \\ H_{21} & H_{22} \end{bmatrix} \begin{bmatrix} \ddot{\theta_1}\\ \ddot{\theta_2} \end{bmatrix} + \begin{bmatrix} h\dot{\theta_2}^2+2h\dot{\theta_1}\dot{\theta_2}\\ h\dot{\theta_1}\dot{\theta_2} \end{bmatrix} + \begin{bmatrix} G_1\\ G_2 \end{bmatrix}" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=H_{11}=m_1l_1^2&plus;j_1&plus;m_2(4l_1^2&plus;l_2^2&plus;4l_1l_2\cos\theta_2)&plus;j_2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?H_{11}=m_1l_1^2&plus;j_1&plus;m_2(4l_1^2&plus;l_2^2&plus;4l_1l_2\cos\theta_2)&plus;j_2" title="H_{11}=m_1l_1^2+j_1+m_2(4l_1^2+l_2^2+4l_1l_2\cos\theta_2)+j_2" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=H_{12}=H_{21}=m_2(l_2^2&plus;2l_1l_2\cos\theta_2)&plus;j_2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?H_{12}=H_{21}=m_2(l_2^2&plus;2l_1l_2\cos\theta_2)&plus;j_2" title="H_{12}=H_{21}=m_2(l_2^2+2l_1l_2\cos\theta_2)+j_2" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=H_{22}=m_2l_2^2&plus;j_2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?H_{22}=m_2l_2^2&plus;j_2" title="H_{22}=m_2l_2^2+j_2" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=h=-2m_2l_1l_2\sin\theta_2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?h=-2m_2l_1l_2\sin\theta_2" title="h=-2m_2l_1l_2\sin\theta_2" /></a>

This gives us the dynamic model(also known as dynamic constraint in controller) of the two arm linkage system. We can see the increase of complexity with number of arms in the equation.

### General method of for multi-arm system

We will use projected Newton Euler Equation to solve for eom of multi-arm system.

(to be continued...)

## Optimal Control Design
