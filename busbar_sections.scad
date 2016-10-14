//// measures in mm
//surrounding insulation thickness
wall = 10;

//basic dimensions of the bus
sections = 3;
len_per_hole = 8.333333333;
num_wire_holes = 4;
section_l = len_per_hole * num_wire_holes;
busses_l = (section_l+wall)*sections + wall;
bus_h = 12;
bus_w = 8;



//horizontal wire holes

wire_hole_v_offset = 1.25; // distance from bottom of bus to bottom of wire hole
wire_hole_spacing = 8;
wire_hole_diameter = 6.5;

//screw down flanges
flange_height = 10;
flange_radius = bus_w/2  + wall ;
mount_hole_diameter = 6; // #10 through-hole =  6

//---------------------------------

// body
difference(){
 // insulation	
 cube([busses_l, bus_w + (wall*2),bus_h + (wall*2)], center=false);
 // cutouts
 union(){
	// the bus itself
    for( i= [0:(sections-1)]){
        translate([i*section_l+(i+1)*wall,wall,wire_hole_v_offset+wall]) 
            cube([section_l,bus_w,bus_h+wall], center = false);
    
    
	// wire holes 
        for( j= [0:(num_wire_holes-1)]){
            translate([wire_hole_spacing/2+wire_hole_spacing*j+(section_l*i)+(i+1)*wall,1+bus_w+wall*2,wall+wall]) rotate([90,0,0]) 
                cylinder(h=bus_w+(wall*2)+2, r = wire_hole_diameter/2, center=false);
        }
    }
 }
}

// mounting flanges
difference(){
	// flanges
	union(){
		translate([busses_l + flange_radius,wall+bus_w/2,0]) 
			cylinder(h=flange_height, r = flange_radius, center=false);
		translate([busses_l,0,0]) 
			cube([flange_radius,flange_radius*2,flange_height], center=false);
		translate([-flange_radius,wall+bus_w/2,0]) 
			cylinder(h=flange_height, r = flange_radius, center=false);
		translate([-flange_radius,0,0]) 
			cube([flange_radius,flange_radius*2,flange_height], center=false);
	}
	// mount holes
	union(){
		translate([busses_l+flange_radius,wall+bus_w/2,-1])  
			cylinder(h=flange_height+2, r = mount_hole_diameter/2, center=false);
		translate([-flange_radius,wall+bus_w/2,-1])  
			cylinder(h=flange_height+2, r = mount_hole_diameter/2, center=false);
	}	
}
