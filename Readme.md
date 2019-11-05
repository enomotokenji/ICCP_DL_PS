# Dictionary based photometric stereo
This code is based on the algorithm proposed in the following paper

    @inproceedings{hui2015dictionary,
	  	title={A dictionary-based approach for estimating shape and spatially-varying reflectance},
	  	author={Hui, Zhuo and Sankaranarayanan, Aswin C},
	  	booktitle={International Conference on Computational Photography (ICCP 2015)},
	  	year={2015}
	}

    @article{hui2017shape,
	  	title={Shape and spatially-varying reflectance estimation from virtual exemplars},
	  	author={Hui, Zhuo and Sankaranarayanan, Aswin C},
	  	booktitle={IEEE Trans. Pattern Analysis and Machine Intelligence (PAMI)},
	  	volume={39},
		number={10},
		pages={2060-2073},
		year={2017}
	}
	

When you use the code to build your algorithm, please cite this paper. 

Please contact the author Zhuo Hui if you have any problems with the code
huizhuo1987@gmail.com

Copy rights reserved by the authors listed above.

### Sphere normal map
 If you would like to use the sphere normals generated in the paper, the normals can be downloaded from Google drive link
https://drive.google.com/drive/folders/0B1ZPX_JY7z6CcTEwOG1vbFlrdk0?usp=sharing

### Prerequisite
 If you want to implement based on this code, please ensure that you have installed the cvx package and set up the root
 correctly. 
 You can download the package from the url http://cvxr.com/cvx/

### Set up
  Run the setup.m to set up the directory 

### Data
  1 surface normal:   include surface normals of the bunny object and corresponding mask. 
  
  2 brdfs:            include only one material BRDF in MERL, and you can download the others from the url:
                      http://people.csail.mit.edu/wojciech/BRDFDatabase/brdfs/
                      Note that you need to convert the binary file to .txt when you want to use the code. 
  
  3 syn_brdf:         synthetic BRDF by random generating the non-negative coefficients, and project to the BRDF dictioanry. 
  
  4 candidate normal: include the candidate normals sets used in the paper, the user can also generate the candidate
		      normals by using the function "genNormals.m"	

### Include
  1 brdf_solver_cvx.m: The function to get the per-pixel coefficients by solving the non-negative lasso problem
  
  2 brdfEst.m:         The function to run the brdf estimation for the estimated surface normals
  
  3 brdfMapping.m:     The function converts the lighting direction, view direction and surface normal to the corresponding 
		       intensity based on different materials
  
  4 calAngE.m:         The function is to calculate the angular error for the normal map
    

  5 genBmatrix.m:      The function used to generate the Bmatrix as indicated in the paper. 
  
  6 genNormals.m:      Generate the candidate normals based on uniform sampling on the sphere
  
  7 genVMap.m:         Generate the vicinity map based on the candidate normals 

  8 initialize.m:      Load the pre-calculated Bmatrix and vicinity map from the specified directory
  
  9 ms_normalEst.m:    Multi-scale searching scheme 
  
  10 pseudoColor.m:    The function converts the normal map to pseudo color for display 
  
  11 relight.m:        Relighting the object based on the given surface normals and BRDF

   
### lighting
  light.m:             The lighting direction based on USC dataset
					   http://gl.ict.usc.edu/LightStages/
 
### scripts
  demo_brdflEst.m:     The script used to demo how to get the per-pixel estimates after obtained the surface normals
  
  demo_generateB.m:    The script used to demo how to generate the B matrix
  
  demo_normalEst.m:    The script used to demo how to get the normal estimates
 
