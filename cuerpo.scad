l_cuerpo=150;//mm
d_cuerpo=30;
r_cuerpo=d_cuerpo/2;
e_cuerpo=0.5;//mm //espesor

d_motor=24;//mm
r_motor=d_motor/2;
l_motor=70;

n_aletas=3;
l_aletas=20;
a_aletas=15;
e_aletas=e_cuerpo;


n_refuerzos=12;
e_refuerzos=3*e_cuerpo;
resalte_refuerzos=e_refuerzos;
fa=1;

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
                  [l_aletas*0.5,r_cuerpo+a_aletas],
                  [l_aletas,r_cuerpo-e_cuerpo]
               ]);
      }
   }

}

// Motor
cylinder(d=d_motor,h=2*l_motor+0.01,center=true);






if (DEBUG) {translate ([0,-1000,-500])cube([1000,1000,1000]);}
}