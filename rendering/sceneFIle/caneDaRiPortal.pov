#version 3.7;

#include "colors.inc"
#include "load_mesh.inc"



camera {
	perspective 					//persp: i raggi convergono in un punto
	location < 0.0, 0.2, -2.0>		// la posizione della camera
	direction < 0, 0, 1> * 5			// change focal lenght
	right < -1.33, 0, 0>				// spcifica i rapporti tra altezza e larghezza
	look_at < 0.0, 0.08, 0.0>		// indica dove la telecamera guarda
}


background { color White}

light_source {
	< 100, 500, -1000>
	color White
	area_light <200, 0, 0>, <0,0,200>, 20,20
	adaptive 1
	}
	
	

	
	

LOAD_MESH("./myMeshes/testaDiCane.mesh", true, 0.5, 0.1, 0.0)		//param2: riflesso metallico, param3 trasparenza
object {
	shape 
	scale 0.002
	rotate <-90, 0, 0>		// indico i gradi
	rotate <0,140,0>		// lo giro col muso in avanti
	translate <0.065,-0.05,-0.2>
	//translate <0, 0, 0>
	texture {
		pigment {
			color Blue
			}
		finish {phong 1}
		normal {bumps 0.4 scale 0.2}
		}
	}
	
	
	disc {		//< vicino-lontano	,	dx-sx	, 	su-giù	>
	<	-0.14, -0.15, -0.1	>, <0.0, 1.0, 0.0>, 0.08
	rotate <90,-60,0>
	//translate <0,0.6,0>
	material {
		texture {
			pigment {
				rgb <0.016804, 0.198351, 1.000000>
			}
			normal {
				brick 0.5 //amount
			}
			finish {
				diffuse 0.6, 0.6
				brilliance 1.0
			}
		}
		interior {
			ior 0.0
		}
	}
}
	
	

LOAD_MESH("./myMeshes/culoDiCane.mesh", true, 0.5, 0.1, 0.0)		//param2: riflesso metallico, param3 trasparenza
object {
	shape 
	scale 0.002
	rotate <-65, 0, 0>		// indico i gradi		x:-90
	rotate <0,140,0>		// lo giro col muso in avanti
	translate <-0.17,-0.00,0.45>	//sposto verso l'alto
	texture {
		pigment {
			color Blue
			}
		finish {phong 1}
		normal {bumps 0.4 scale 0.2}
		}
	}
	




disc {
	<0.1, 0.15, -0.15>, <0.0, 1.0, 0.0>, 0.06
	rotate <90,-70,0>
	//translate <0,0.6,0>
	material {
		texture {
			pigment {
				rgb <2,	0.65, 0	>
			}
			normal {
				brick 0.5 //amount
			}
			finish {
				diffuse 0.6, 0.6
				brilliance 1.0
			}
		}
		interior {
			ior 0.0
		}
	}
}



	
// aggiungo un piano che permetta la proiezione delle ombre

plane {
	<0,1,0>, 0 // è la nomale, punta verso le y; 0 è la distanza dall'origine
	pigment {color White}
	finish {
		ambient 0.2					// crea un ombra attorno alla shape
		brilliance 0
	}
}