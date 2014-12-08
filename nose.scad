module nose() {
  union(){
    difference(){
      translate([80,0,y+10])rotate([180,0,0])paraboloid (y, f, rfa, fc, detail);
      translate([80,0,y-e_cuerpo*3+10])rotate([180,0,0])paraboloid (y, f, rfa, fc, detail);
    }
    difference(){
      translate([80,0,0]) cylinder(r=y/2,h=10);
      translate([80,0,0]) cylinder(r=y/2-1,h=11);
    }
  }
}