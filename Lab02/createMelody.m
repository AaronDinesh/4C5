function [y, nOut] = createMelody(notes, duration, fs, octave_change)
    y = [];
for i = notes
    yNote = createNote(i,duration,fs, octave_change);
    y = [y yNote];
end

nOut = 0:1/fs:duration-1/fs;
end


