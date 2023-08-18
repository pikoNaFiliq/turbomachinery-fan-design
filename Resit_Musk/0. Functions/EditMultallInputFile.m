function EditMultallInputFile(restart)

copyfile("stage_new.dat","stage_new_copy.dat")
input_file = fopen("stage_new_copy.dat");
ouput_file = fopen("stage_new.dat","w");

change_next_line = false;

while ~feof(input_file)
    tline = fgetl(input_file);

    if change_next_line && restart 
        change_next_line = false;
        tline="     1";
    end

    if contains(tline,"IF_RESTART") && restart 
        change_next_line = true;
    end



    fprintf(ouput_file, "%s \n",tline);
end

fclose(input_file);
fclose(ouput_file);


end