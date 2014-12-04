include <config.scad>;
include <paraboloid.scad>;

//height of paraboloid
y=30+2*e_cuerpo+2 ; //[0:100]

//focus distance
f=2;	//[0:100]

//center paraboloid position
fc=0;	// [1,0]

//radius of the focus area :
rfa=0 ;//[0:100]

// detail = $fn of cone
detail=60; //[44:240]


// Nose


DEBUG=false;

difference(){
union(){
// Cuerpo del cohete
difference(){
   cylinder(r=r_cuerpo, h=l_cuerpo, $fa=fa);
	translate ([0,0,-l_cuerpo/2]) cylinder(r=r_cuerpo-e_cuerpo, h=2*l_cuerpo, $fa=fa);
   }

// Agare del motor

   //translate([0,0,l_motor]) cylinder(r=r_cuerpo, h=e_refuerzos);
   
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

// Motor
cylinder(d=d_motor,h=2*l_motor+0.01,center=true);



if (DEBUG) {translate ([0,-1000,-500])cube([1000,1000,1000]);}
}


// Cono
difference(){
translate([80,0,y])rotate([180,0,0])paraboloid (y, f, rfa, fc, detail);
translate([80,0,y-e_cuerpo])rotate([180,0,0])paraboloid (y, f, rfa, fc, detail);
}
//translate([80,0,0])cylinder(r=r_cuerpo,h=10);
