battery_length = 321;
battery_width = 152;
battery_pole_offset_x = 51;
battery_pole_offset_y = 27;

battery_spacing = 15;

box_wall_thickness = 8;
box_wall_height= 300;

module victron_smart_battery_200Ah()
{
    color("lightblue")
        cube([battery_length,battery_width,228]);
    translate([8,45,228])
        color("lightblue")
            cube([305,97,9]);
    translate([70,8,228])
        color("lightblue")
            cube([180,37,9]);
    translate([battery_pole_offset_x,battery_pole_offset_y,228])
        color("red")
            cylinder(9, d=25);
    translate([battery_length-battery_pole_offset_x,battery_pole_offset_y,228])
        color("black")
            cylinder(9, d=25);
}

module victron_multiplus2_48_3000()
{
    color("lightblue")
        cube([275,147,506]);
}

module victron_smart_batteryprotect_48_100()
{
    color("lightblue")
        cube([123,120,62]);
}

module victron_smart_shunt_500A()
{
    color("lightblue")
       cube([154,48,78]);   
}

module victron_cerbo_gx()
{
    color("lightblue")
       cube([154,48,78]);   
}

module victron_vebus_bms()
{
    color("black")
        cube([105,32,78]);
}

module bluesea_powerbar_600A()
{
    color("silver")
        cube([180,50,50]);
}

module connector_short()
{
    color("silver")
        cube([battery_pole_offset_y*2+15*2+battery_spacing,30,5]);
}
module connector_long()
{
    color("silver")
        cube([battery_pole_offset_x*2+15*2+battery_spacing,30,5]);
}

module string_48VDC()
{
    victron_smart_battery_200Ah();
    translate([battery_length+battery_spacing,0,0])
        victron_smart_battery_200Ah();
    translate([battery_length*2+battery_spacing,-battery_spacing,0])
        rotate(a=180)
            victron_smart_battery_200Ah();
    translate([battery_length,-battery_spacing,0])
        rotate(a=180)
            victron_smart_battery_200Ah();
}

module bank_48VDC()
{
    string_48VDC();
    translate([battery_length-battery_pole_offset_x-15,battery_pole_offset_y-15,237])
        connector_long();
    translate([battery_length*2+battery_spacing-battery_pole_offset_x+15,-battery_pole_offset_y-battery_spacing-15,237])
        rotate(a=90)
            connector_short();
    translate([battery_length-battery_pole_offset_x-15,-battery_pole_offset_y-battery_spacing-15,237])
        connector_long();
        
}

module box_bottom_lid()
{
    color("beige")
        cube([battery_length*2+battery_spacing*3,
              battery_width*2+battery_spacing*3,
              box_wall_thickness]);
}

module box_longside()
{
    color("beige")
        cube([battery_length*2+battery_spacing*3+box_wall_thickness*2,box_wall_thickness,box_wall_height]);
}

module box_shortside()
{
    color("beige")
        cube([box_wall_thickness,battery_width*2+battery_spacing*3,box_wall_height]);
}

module box()
{    
    translate([box_wall_thickness,box_wall_thickness,0])
        box_bottom_lid();
    translate([0,0,box_wall_thickness])
        box_longside();
    translate([0,battery_width*2+battery_spacing*3+box_wall_thickness,box_wall_thickness])
        box_longside();
    translate([0,box_wall_thickness,box_wall_thickness])
        box_shortside();
    translate([battery_length*2+battery_spacing*3+box_wall_thickness,box_wall_thickness,box_wall_thickness])
        box_shortside();
    translate([0,0,box_wall_height+box_wall_thickness])
        *#box_bottom_lid();
}

module battery_box()
{
    box();
    translate([box_wall_thickness+battery_spacing,box_wall_thickness+battery_spacing+battery_width+battery_spacing,box_wall_thickness])
        bank_48VDC();
}

module electric_panel()
{
    color("beige")
        cube([800,10,600]);
    translate([0,-48,0])
        victron_smart_shunt_500A();
    translate([170,-50,0])
        bluesea_powerbar_600A();
    translate([55,-50,280])
        rotate([0,90,0])
            bluesea_powerbar_600A();
    translate([0,-32,300])
        victron_vebus_bms();
    translate([0,-48,450])
        victron_cerbo_gx();    
    translate([525,-147,94])
        victron_multiplus2_48_3000();
}

module show_system()
{
battery_box();
translate([-140,-184,-10])
    electric_panel();
}

module print_dimensions()
{
    echo("Box bottom LxW", battery_length*2+battery_spacing*3, battery_width*2+battery_spacing*3);
    echo("Box longside LxH", battery_length*2+battery_spacing*3+box_wall_thickness*2, box_wall_height);
    echo("Box shortside LxH", battery_width*2+battery_spacing*3, box_wall_height);
    echo("Connector short LxW", battery_pole_offset_y*2+15*2+battery_spacing, 30);
    echo("Connector long LxW", battery_pole_offset_x*2+15*2+battery_spacing, 30);
}

show_system();
print_dimensions();
