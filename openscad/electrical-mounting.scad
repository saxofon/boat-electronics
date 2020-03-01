module victron_smart_battery_200Ah()
{
    color("lightblue")
        cube([321,152,228]);
    translate([8,45,228])
        color("lightblue")
            cube([305,97,9]);
    translate([70,8,228])
        color("lightblue")
            cube([180,37,9]);
    translate([51,27,228])
        color("red")
            cylinder(9, d=25);
    translate([271,27,228])
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
        cube([89,30,5]);
}
module connector_long()
{
    color("silver")
        cube([138,30,5]);
}

module string_48VDC()
{
    victron_smart_battery_200Ah();
    translate([326,0,0])
        victron_smart_battery_200Ah();
    translate([647,-5,0])
        rotate(a=180)
            victron_smart_battery_200Ah();
    translate([321,-5,0])
        rotate(a=180)
            victron_smart_battery_200Ah();
}

module bank_48VDC()
{
    string_48VDC();
    translate([255,12,237])
        connector_long();
    translate([611,-47,237])
        rotate(a=90)
            connector_short();
    translate([255,-47,237])
        connector_long();
        
}

module box_bottom_lid()
{
    color("beige")
        cube([677,339,10]);
}

module box_longside()
{
    color("beige")
        cube([677,10,250]);
}

module box_shortside()
{
    color("beige")
        cube([10,319,250]);
}

module box()
{    
    translate([-15,-172,-10])
        box_bottom_lid();
    translate([-15,-172,0])
        box_longside();
    translate([-15,157,0])
        box_longside();
    translate([-15,-162,0])
        box_shortside();
    translate([652,-162,0])
        box_shortside();
    translate([-15,-172,250])
        *box_bottom_lid();
}

module battery_box()
{
    box();
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

battery_box();
translate([-140,-184,-10])
    electric_panel();