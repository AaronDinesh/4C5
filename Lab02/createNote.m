function [y, nOut] = createNote(note, duration, fs, octave_change)
    nOut = (0:1/fs:duration-1/fs);

    if(note == -1)
        y = zeros(1,length(nOut));
    else
        fNote = round(440 * power(2, (((note+(octave_change*12)) - 69) / 12)), 2);
        y = sin(2*pi*fNote*nOut);
    end 
end

