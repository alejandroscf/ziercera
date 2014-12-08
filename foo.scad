l_cuerpo=240;//mm
d_cuerpo=30;
r_cuerpo=d_cuerpo/2;
e_cuerpo=1;//mm //espesor

d_motor=24;//mm
r_motor=d_motor/2;
l_motor=70;

n_aletas=3;
l_aletas=90;
a_aletas=60;
e_aletas=1;


n_refuerzos=12;
e_refuerzos=3*e_cuerpo;
resalte_refuerzos=3;
fa=1;

// NOSE
//height of paraboloid
y=34; //[0:100]

//focus distance
f=2;    //[0:100]

//center paraboloid position
fc=0;   // [1,0]

//radius of the focus area :
rfa=0 ;//[0:100]

// detail = $fn of cone
detail=50; //[44:240]


DEBUG=false;
//////////////////////////////////////////////////////////////////////////////////////////////
// Paraboloid module for OpenScad
//
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// This program is free software. It is 
// licensed under the Attribution - Creative Commons license.
// http://creativecommons.org/licenses/by/3.0/
//////////////////////////////////////////////////////////////////////////////////////////////
//Edited by Takuya Yamaguchi for making customaizable.
//////////////////////////////////////////////////////////////////////////////////////////////

//height of paraboloid
y=50 ; //[0:100]

//focus distance
f=10;	//[0:100]

//center paraboloid position
fc=1;	// [1,0]

//radius of the focus area :
rfa=0 ;//[0:100]

// detail = $fn of cone
detail=120; //[44:240]

module paraboloid (y, f, rfa, fc, detail){
	// y = height of paraboloid
	// f = focus distance 
	// fc : 1 = center paraboloid in focus point(x=0, y=f); 0 = center paraboloid on top (x=0, y=0)
	// rfa = radius of the focus area : 0 = point focus
	// detail = $fn of cone

	hi = (y+2*f)/sqrt(2);								// height and radius of the cone -> alpha = 45° -> sin(45°)=1/sqrt(2)
	x =2*f*sqrt(y/f);									// x  = half size of parabola
	
   translate([0,0,-f*fc])								// center on focus 
	rotate_extrude(convexity = 10,$fn=detail )		// extrude paraboild
	translate([rfa,0,0])								// translate for fokus area	 
	difference(){
		union(){											// adding square for focal area
			projection(cut = true)											// reduce from 3D cone to 2D parabola
				translate([0,0,f*2]) rotate([45,0,0])								// rotate cone 45° and translate for cutting
				translate([0,0,-hi/2])cylinder(h= hi, r1=hi, r2=0, center=true, $fn=detail);   	// center cone on tip
			translate([-(rfa+x ),0]) square ([rfa+x , y ]);								// focal area square
		}
		translate([-(2*rfa+x ), -1/2]) square ([rfa+x ,y +1] ); 					// cut of half at rotation center 
	}
}
include <config.scad>;
include <paraboloid.scad>;
include <nose.scad>;

difference(){
  union(){
  // Cuerpo del cohete
    difference(){
      cylinder(r=r_cuerpo, h=l_cuerpo, $fa=fa);
      translate ([0,0,-l_cuerpo/2]) cylinder(r=r_cuerpo-e_cuerpo, h=2*l_cue  rpo, $fa=fa);
    }

    // Agare del motor
    //Refuerzos
    for ( i = [0 : n_refuerzos] ) {
      rotate([0,0,i*360/n_refuerzos]) {
        translate([-e_refuerzos/2,0,0])
        cube([e_refuerzos,r_cuerpo-e_cuerpo,l_motor+0.001]);
        translate([e_refuerzos/2,0,l_motor]) 
        rotate([0,-90,0])
        linear_extrude (height=e_refuerzos)
        polygon([
        [0,r_motor-resalte_refuerzos],
        [0,r_cuerpo-e_cuerpo],
        [(r_cuerpo-e_cuerpo-(r_motor-resalte_refuerzos))/tan(30),r_cuerpo-e_cuerpo]
        ]);
      }
    }

    // Aletas
    for ( i = [0 : n_aletas] ) {
      rotate([0,0,i*360/n_aletas]) {
        //translate([-e_aletas/2,r_cuerpo-e_cuerpo,0])
        //   cube([e_aletas,a_aletas+e_cuerpo,l_aletas]);
        translate([-e_aletas/2,0,0])
        rotate([0,-90,0])
        linear_extrude (height=e_aletas)
        polygon([
        [0,r_cuerpo-e_cuerpo],
        [0,r_cuerpo+a_aletas],
        [l_aletas*0.2,r_cuerpo+a_aletas],
        [l_aletas,r_cuerpo-e_cuerpo]
        ]);
        }
      }
    }
  }
  
  // Motor
  cylinder(d=d_motor,h=2*l_motor+0.01,center=true);
} 
  if (DEBUG) {translate ([0,-1000,-500])cube([1000,1000,1000]);}

  // Cono
  nose();

  //translate([80,0,0])cylinder(r=r_cuerpo,h=10);
