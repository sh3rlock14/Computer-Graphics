#version 3.7;

#include "colors.inc"
#include "load_mesh.inc"



camera {
	perspective 					//persp: i raggi convergono in un punto
	location < 0.0, 0.2, -1.3>		// la posizione della camera
	direction < 0, 0, 1> * 5			// change focal lenght
	right < -1.33, 0, 0>				// spcifica i rapporti tra altezza e larghezza
	look_at < 0.0, 0.08, 0.0>		// indica dove la telecamera guarda
}


background { color White}

light_source {
	< 100, 500, -1000>
	color Red
	area_light <400, 0, 0>, <0,0,400>, 20,20
	adaptive 1
	}
	
	
	sphere {
		<0.0, 0.0, 0.0>, 0.02
		translate <0.03,0.05,0.06>	//sposto verso l'alto
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
			//interior {
			//	ior 1.3
			//}
		}
	}

	
	
	
LOAD_MESH("./myMeshes/tigrrCat.mesh", true, 0.5, 0.1, 0.0)		//param2: riflesso metallico, param3 trasparenza
object {
	shape 
	scale 0.002
	rotate <-90, 0, 0>		// indico i gradi
	rotate <0,160,0>		// lo giro col muso in avanti
	translate <0,0.06,0.2>	//sposto verso l'alto
	texture {
		pigment {
			color Blue
			}
		finish {phong 1}
		normal {bumps 0.4 scale 0.2}
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