function [umax,radius_tip] = FindUmax(rads,meangen_output)
    
    pattern = "ROW 2 TIP RADIUS";
    index = strfind(meangen_output,pattern);
  
    line_of_interest = meangen_output(index(end):index(end)+24);
    cells_of_interest = split(line_of_interest," ");
    radius_tip = str2double(cells_of_interest{end});
    umax = rads * radius_tip;

end