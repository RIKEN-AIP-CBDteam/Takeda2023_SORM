# Sensor array Optimization based on Resolution Matrix (SORM)

2023-07-05 Yusuke Takeda

## Introduction
This toolbox contains MATLAB programs to perform the SORM algorithm proposed in the following paper.  
- Takeda, Y., Gomi, T., Umebayashi, R., Tomita, S., Suzuki, K., Hiroe, N., Saikawa, J., Munaka, T., Yamashita, O., 2023. Sensor array design of optically pumped magnetometers for accurately estimating source currents. NeuroImage, 120257.

SORM designs sensor arrays of optically pumped magnetometers (OPMs) for accurately estimating the cortical currents at regions of interest (ROIs). Based on the resolution matrix of minimum norm estimate (MNE), it sequentially determines the position of each sensor to optimize its inverse filter pointing to the ROIs and suppressing the signal leakage from the other areas. Although SORM is based on MNE, the sensor arrays designed by SORM were effective not only when we estimated the cortical currents by MNE but also when we did so by other methods.

## System requirement
This toolbox works on MATLAB (R2011b or later).

## How to start
Please execute the codes in "demo.m" step by step to learn how this toolbox works.

## Programs
This toolbox contains the following programs.
- demo.m: Demonstrate the SORM algorithm
- SORM.m: Perform the SORM algorithm
- plot_sensor.m: Plot sensor array

## Data
The sample data in this toolbox were made from [the multi-subject, multi-modal neuroimaging dataset](https://openneuro.org/datasets/ds000117/versions/1.0.1/) (OpenNEURO ds000117-v1.0.1, sub-01) created by Wakeman and Henson (2015) using [VBMEG](https://vbmeg.atr.jp/).

## Feedback & Bug report
Any feedback and bug reports are welcome. Please contact me if you have any questions (takeda@atr.jp).

## License
Redistribution and use in source and binary forms, with or without modification, are permitted for non-commercial purposes.

## Acknowledgments
This research was supported by a contract with the National Institute of Information and Communications Technology entitled "Analysis of multi-modal brain measurement data and development of its application for BMI open innovation" (209). It was also supported by JSPS KAKENHI (Grant Number 21K07269).

## References
- Takeda, Y., Gomi, T., Umebayashi, R., Tomita, S., Suzuki, K., Hiroe, N., Saikawa, J., Munaka, T., Yamashita, O., 2023. Sensor array design of optically pumped magnetometers for accurately estimating source currents. NeuroImage, 120257.
- Wakeman, D.G., and Henson, R.N., 2015. A multi-subject, multi-modal human neuroimaging dataset. Sci. Data 2, 150001.
