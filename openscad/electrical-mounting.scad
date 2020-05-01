battery_length = 321;
battery_width = 152;
battery_pole_offset_x = 51;
battery_pole_offset_y = 27;

battery_spacing = 15;
bs_height = 200;
bs_length = 45;
bs_thickness = 12;

box_wall_thickness = 8;
box_wall_height = 300;
box_bottom_thickness = 12;
box_lid_thickness = 8;

isolation = 30;

module victron_smart_battery_200Ah()
{
    height=228;
    
    color("lightblue")
        cube([battery_length,battery_width,height]);
    translate([8,45,height])
        color("lightblue")
            cube([305,97,9]);
    translate([70,8,height])
        color("lightblue")
            cube([180,37,9]);
    translate([battery_pole_offset_x,battery_pole_offset_y,height])
        color("red")
            cylinder(9, d=25);
    translate([battery_length-battery_pole_offset_x,battery_pole_offset_y,height])
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

module bluesea_breaker_panel(ampere)
{
    width=60;
    length=55;
    thickness=9;
    
    color("grey")
        cylinder(h=40,d=53.5,center=false);
    translate([-width/2,-length/2,0])
        color("grey")
            cube([width,length,thickness],center=false);
    translate([0,-17,0])
        rotate([0,0,45])
            color("grey")
                cube([42,42,thickness],center=false);
    translate([0,-43,0])
        rotate([0,0,45])
            color("grey")
                cube([42,42,thickness],center=false);
    translate([15,-0,40])
        color("silver")
            cylinder(h=15,d=8,center=false);
    translate([-15,-0,40])
        color("silver")
            cylinder(h=15,d=8,center=false);
}

module bluesea_connector_throughpanel(color)
{
    thickness=8;
    length=50;
    width=31.5;
    height=30;
    color(color)
        cylinder(h=height,d1=23,d2=20.5,center=false);
    translate([-width/2,-length/2,0])
        color(color)
            cube([width,length,thickness],center=false);
    translate([0,0,-25])
        color("silver")
            cylinder(h=80,d=9,center=false);
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

module box_bottom()
{
    color("beige")
        cube([battery_length*2+battery_spacing*3,
              battery_width*2+battery_spacing*3,
              box_bottom_thickness]);
}

module box_lid()
{
    color("beige")
        cube([battery_length*2+battery_spacing*3+box_wall_thickness*2,
              battery_width*2+battery_spacing*3+box_wall_thickness*2,
              box_lid_thickness]);
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

module box_extrapanel()
{
    color("AntiqueWhite")
        cube([box_wall_thickness,230,140]);
}

module box()
{    
    translate([box_wall_thickness,box_wall_thickness,0])
        box_bottom();
    translate([0,0,0])
        box_longside();
    translate([0,battery_width*2+battery_spacing*3+box_wall_thickness,0])
        box_longside();
    translate([0,box_wall_thickness,0])
        box_shortside();
    translate([battery_length*2+battery_spacing*3+box_wall_thickness,box_wall_thickness,0])
        box_shortside();
    translate([0,0,box_wall_height])
        *box_lid();
}

module bs_corner()
{
    cube([battery_spacing+bs_length, battery_spacing, bs_thickness]);
    cube([battery_spacing, battery_spacing+bs_length, bs_thickness]);
    translate([battery_spacing/2, battery_spacing/2, bs_thickness])
        cylinder(d=battery_spacing, bs_height-bs_thickness*2);
    translate([0, 0, bs_height-bs_thickness]) {
        cube([battery_spacing+bs_length, battery_spacing, bs_thickness]);
        cube([battery_spacing, battery_spacing+bs_length, bs_thickness]);
    }
}

module bs_side()
{
    cube([battery_spacing+bs_length*2, battery_spacing, bs_thickness]);
    translate([bs_length, 0, 0])
        cube([battery_spacing, battery_spacing+bs_length, bs_thickness]);
    translate([bs_length+battery_spacing/2, battery_spacing/2, bs_thickness])
        cylinder(d=battery_spacing, bs_height-bs_thickness*2);
    translate([0, 0, bs_height-bs_thickness]) {
        cube([battery_spacing+bs_length*2, battery_spacing, bs_thickness]);
        translate([bs_length, 0, 0])
            cube([battery_spacing, battery_spacing+bs_length, bs_thickness]);
    }
}

module bs_middle()
{
    cube([battery_spacing+bs_length*2, battery_spacing, bs_thickness]);
    translate([bs_length, -bs_length, 0])
        cube([battery_spacing, battery_spacing+bs_length*2, bs_thickness]);
    translate([bs_length+battery_spacing/2, battery_spacing/2, bs_thickness])
        cylinder(d=battery_spacing, bs_height-bs_thickness*2);
    translate([0, 0, bs_height-bs_thickness]) {
        cube([battery_spacing+bs_length*2, battery_spacing, bs_thickness]);
        translate([bs_length, -bs_length, 0])
            cube([battery_spacing, battery_spacing+bs_length*2, bs_thickness]);
    }
}
module battery_box()
{
    color("silver")
        translate([box_wall_thickness, box_wall_thickness,box_bottom_thickness])
            cube([battery_length*2+battery_spacing*3, battery_width*2+battery_spacing*3,
                    isolation]);
    
    difference() {
        box();
        translate([-1,80,250])
            cube([box_wall_thickness+2,200,51]);
    }
    translate([box_wall_thickness+battery_spacing,box_wall_thickness+battery_spacing+battery_width+battery_spacing,box_bottom_thickness+isolation])
        bank_48VDC();
    
    translate([box_wall_thickness, box_wall_thickness,box_bottom_thickness+isolation])
        bs_corner();
    translate([box_wall_thickness, box_wall_thickness+battery_width*2+battery_spacing*3,box_bottom_thickness+isolation])
        rotate([0,0,270])
            bs_corner();
    translate([box_wall_thickness+battery_length*2+battery_spacing*3, box_wall_thickness+battery_width*2+battery_spacing*3,box_bottom_thickness+isolation])
        rotate([0,0,180])
            bs_corner();
    translate([box_wall_thickness+battery_length*2+battery_spacing*3, box_wall_thickness,box_bottom_thickness+isolation])
        rotate([0,0,90])
            bs_corner();
    translate([box_wall_thickness+battery_length+battery_spacing-bs_length, box_wall_thickness,box_bottom_thickness+isolation])
        bs_side();
    translate([box_wall_thickness, box_wall_thickness+battery_width+battery_spacing*2+bs_length,box_bottom_thickness+isolation])
        rotate([0,0,270])
            bs_side();
    translate([box_wall_thickness+battery_length+battery_spacing*2+bs_length, box_wall_thickness+battery_width*2+battery_spacing*3,box_bottom_thickness+isolation])
        rotate([0,0,180])
            bs_side();
    translate([box_wall_thickness+battery_length*2+battery_spacing*3, box_wall_thickness+battery_width+battery_spacing-bs_length,box_bottom_thickness+isolation])
        rotate([0,0,90])
            bs_side();
    translate([box_wall_thickness+battery_length+battery_spacing-bs_length, box_wall_thickness+battery_width+battery_spacing,box_bottom_thickness+isolation])
        bs_middle();
    translate([-60,65,160])
        box_extrapanel();
    translate([-68,155,180])
        rotate([0,90,0])
            bluesea_connector_throughpanel("black");
    translate([-68,217,180])
        rotate([0,90,0])
            bluesea_connector_throughpanel("red");
    translate([-68,185,250])
        rotate([90,0,90])
            bluesea_breaker_panel(200);
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
translate([-100,-30,-10])
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
