
solarpanel_width = 1045;
solarpanel_length = 1690;
solarpanel_height = 40;

profile_width = 30;

module solarpanel()
{
    color("gray")
        cube([solarpanel_width,solarpanel_length,solarpanel_height]);
}

module profile_aft_fore()
{
    color("silver")
        cube([solarpanel_width*2,profile_width,profile_width]);
}

module profile_sides()
{
    color("silver")
        cube([solarpanel_length-profile_width*2,profile_width,profile_width]);
}

module profile_middle()
{
    color("silver")
        cube([solarpanel_length-profile_width*2,profile_width*2,profile_width]);
}

module solarinstallation()
{
    translate([0,0,profile_width])
        solarpanel();
    translate([solarpanel_width+1,0,profile_width])
        solarpanel();
    profile_aft_fore();
    translate([0,solarpanel_length-profile_width,0])
        profile_aft_fore();
    translate([profile_width,profile_width,0])
        rotate([0,0,90])
            profile_sides();
    translate([solarpanel_width*2,profile_width,0])
        rotate([0,0,90])
            profile_sides();
    translate([solarpanel_width,profile_width,0])
        rotate([0,0,90])
            profile_middle();
}

module print_dimensions()
{
    echo("Profile aft/fore, 2 of ", solarpanel_width*2, "mm of ", profile_width, "x", profile_width, " mm");
    echo("Profile sides, 2 of ", solarpanel_length-profile_width*2, "mm of ", profile_width, "x", profile_width, " mm");
    echo("Profile middle, 1 of ", solarpanel_length-profile_width*2, "mm of ", profile_width*2, "x", profile_width, " mm");
}


solarinstallation();
print_dimensions();
