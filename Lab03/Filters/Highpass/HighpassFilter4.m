function Hd = HighpassFilter4
%HIGHPASSFILTER4 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.14 and DSP System Toolbox 9.16.
% Generated on: 07-Nov-2023 17:27:00

% Generalized REMEZ FIR Highpass filter designed using the FIRGR function.

% All frequency values are in Hz.
Fs = 8000;  % Sampling Frequency

Fstop = 95;              % Stopband Frequency
Fpass = 700;             % Passband Frequency
Dstop = 0.001;           % Stopband Attenuation
Dpass = 0.057501127785;  % Passband Ripple
in    = 4;               % Initial order estimate
dens  = 20;              % Density Factor
phase = 'minphase';      % Phase Specification

% Calculate the coefficients using the FIRGR function.
b  = firgr({'mineven', in}, [0 Fstop Fpass Fs/2]/(Fs/2), [0 0 1 1], ...
           [Dstop Dpass], {dens}, phase);
Hd = dfilt.dffir(b);

% [EOF]
