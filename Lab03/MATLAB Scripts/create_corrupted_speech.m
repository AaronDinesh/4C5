close all
clear

filename = 'OSR_us_000_0010_8k.wav';
[y, fs] = audioread(filename);

%super-imposed tone created with createNote.m
%use same sampling frequency as the speech file i.e. fs=8000Hz
[x1,new_t] = createNote(length(y)/fs,20,fs,0,0.01);
[x2,new_t] = createNote(length(y)/fs,105,fs,0,0.01);

%add the two signals (wav file and tone)
%x=...;
corrupted_speech = x1+y+x2;

%listen to the resulting corrupted speech
%sound(corrupted_speech);

audiowrite("OSR_20_105_Corrupted.wav", corrupted_speech, fs)