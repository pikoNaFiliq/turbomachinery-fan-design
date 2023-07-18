function EditStagenInputFile(n_blades_stator,n_blades_rotor)
copyfile("stagen.dat","stagen_copy.dat")
input_file = fopen("stagen_copy.dat");
ouput_file = fopen("stagen.dat","w");

stator = false;
rotor = false;

if exist("n_blades_stator","var") || exist("n_blades_rotor","var")
    change_blade = true;
else
    change_blade = false;
end

while ~feof(input_file)
    tline = fgetl(input_file);

    if contains(tline,"IM")
        tline = replace(tline,"37",sprintf("%i",constants.IM));
    end
    
    if contains(tline,"BLADE ROW  TYPE") && change_blade
        if contains(tline,"=    S")
            stator = true;
            rotor = false;
        elseif contains(tline,"=    R")
            stator = false;
            rotor = true;
        end
    end
    
    if contains(tline,"NUMBER OF BLADES IN ROW.") && change_blade 
        num = regexp(tline, '\d+', 'match');
        if stator
            tline = replace(tline,num,sprintf("%i",n_blades_stator));
        elseif rotor
            tline = replace(tline,num,sprintf("%i",n_blades_rotor));
        end
        
    end



    fprintf(ouput_file, "%s \n",tline);
end

fclose(input_file);
fclose(ouput_file);


end