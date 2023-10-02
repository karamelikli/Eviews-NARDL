


subroutine    DateToInt(  string %in, scalar !q1 )
if !ifVarLar=1 then
	%y = @wreplace(%in,"*/*","* *")
	%y = @wreplace(%y,"*/*","* *")
	%Yt=@word({%y},3)+@word({%y},1)+@word({%y},2)
	
	 !q1=@val(%Yt) 
 endif
endsub



 
subroutine license(    )
if !ifVarLar=1 then
      %license=@getnextname("ZZ__license")
      text {%license}
      {%license}.append  "This code has been written by Huseyin Karamelikli (Hossein Haghparast Gharamaleki) Thanks to Yashar Tarverdi. Him works is expanded here in some directions. Thanks to Dave Giles for very usfull guidness about ARDL at him powerfull weblog."
      {%license}.append "Please note that this program is beta version and lunched only for test propose. Final version might released with MIT license when all bugs would be repaired."
      {%license}.append	"Please dont redistribute it while it is not released as Final version by MIT license. For any questions or comments please contact hakperest@gmail.com . This version is allowed only for Sefa Erkus to test of program propose. "
      {%sp}.append   {%license}
      !sayfaNo=!sayfaNo+1
      {%sp}.name  !sayfaNo "license"
endif
endsub


subroutine MassRun( )
if !ifVarLar=1 then
	output(r) {%OutputFile}
	print  {%sp}
	output off
	'd {%sp}

endif
endsub



subroutine NarayanTable(  )
if !ifVarLar=1 then

	 ' %NmatNcNt=@getnextname("ZZ__N_NcNt") 'no intercept No trend
	  %NmatRcNt=@getnextname("ZZ__N_RcNt") 'restricted intercept No trend
	  %NmatUcNt =@getnextname("ZZ__N_UcNt") 'Unrestricted intercept No trend
	  %NmatUcRt =@getnextname("ZZ__N_UcRt")'Unrestricted intercept ristricted trend
	  %NmatUcUt =@getnextname("ZZ__N_UcUt")'Unrestricted intercept unristricted trend
	  'matrix(17,33) {%NmatNcNt}
	  matrix(17,33) {%NmatRcNt}
	  matrix(17,33) {%NmatUcNt}
	  matrix(17,33) {%NmatUcRt}
	  matrix(17,33) {%NmatUcUt}
	 ' {%NmatNcNt}.fill 
	  {%NmatRcNt}.fill 30,7.595,7.595,6.027,6.76,5.155,6.265,4.614,5.966,4.28,5.84,4.134,5.761,3.976,5.691,3.864,5.694,35,7.35,7.35,5.763,6.48,4.948,6.028,4.428,5.816,4.093,5.532,3.9,5.419,3.713,5.326,3.599,5.23,40,7.22,7.22,5.593,6.333,4.77,5.855,4.31,5.544,3.967,5.455,3.657,5.256,3.505,5.121,3.402,5.031,45,7.265,7.265,5.607,6.193,4.8,5.725,4.27,5.412,3.892,5.173,3.674,5.019,3.54,4.931,3.383,4.832,50,7.065,7.065,5.503,6.24,4.695,5.758,4.188,5.328,3.845,5.15,3.593,4.981,3.424,4.88,3.282,4.73,55,6.965,6.965,5.377,6.047,4.61,5.563,4.118,5.2,3.738,4.947,3.543,4.839,3.33,4.708,3.194,4.562,60,6.96,6.96,5.383,6.033,4.558,5.59,4.068,5.25,3.71,4.965,3.451,4.764,3.293,4.615,3.129,4.507,65,6.825,6.825,5.35,6.017,4.538,5.475,4.056,5.158,3.725,4.94,3.43,4.721,3.225,4.571,3.092,4.478,70,6.74,6.74,5.157,5.957,4.398,5.463,3.916,5.088,3.608,4.86,3.373,4.717,3.18,4.596,3.034,4.426,75,6.915,6.915,5.26,5.957,4.458,5.41,4.048,5.092,3.687,4.842,3.427,4.62,3.219,4.526,3.057,4.413,80,6.695,6.695,5.157,5.917,4.358,5.393,3.908,5.004,3.602,4.787,3.351,4.587,3.173,4.485,3.021,4.35,30,5.07,5.07,4.09,4.663,3.538,4.428,3.272,4.306,3.058,4.223,2.91,4.193,2.794,4.148,2.73,4.163,35,4.945,4.945,3.957,4.53,3.478,4.335,3.164,4.194,2.947,4.088,2.804,4.013,2.685,3.96,2.597,3.907,40,4.96,4.96,3.937,4.523,3.435,4.26,3.1,4.088,2.893,4,2.734,3.92,2.618,3.863,2.523,3.829,45,4.895,4.895,3.877,4.46,3.368,4.203,3.078,4.022,2.85,3.905,2.694,3.829,2.591,3.766,2.504,3.723,50,4.815,4.815,3.86,4.44,3.368,4.178,3.048,4.002,2.823,3.872,2.67,3.781,2.55,3.708,2.457,3.65,55,4.795,4.795,3.79,4.393,3.303,4.1,2.982,3.942,2.763,3.813,2.617,3.743,2.49,3.658,2.414,3.608,60,4.78,4.78,3.803,4.363,3.288,4.07,2.962,3.91,2.743,3.792,2.589,3.683,2.456,3.598,2.373,3.54,65,4.78,4.78,3.787,4.343,3.285,4.07,2.976,3.896,2.75,3.755,2.596,3.677,2.473,3.583,2.373,3.519,70,4.75,4.75,3.78,4.327,3.243,4.043,2.924,3.86,2.725,3.718,2.564,3.65,2.451,3.559,2.351,3.498,75,4.76,4.76,3.777,4.32,3.253,4.065,2.946,3.862,2.725,3.718,2.574,3.641,2.449,3.55,2.36,3.478,80,4.725,4.725,3.74,4.303,3.235,4.053,2.92,3.838,2.688,3.698,2.55,3.606,2.431,3.518,2.336,3.458,30,4.025,4.025,3.303,3.797,2.915,3.695,2.676,3.586,2.525,3.56,2.407,3.517,2.334,3.515,2.277,3.498,35,3.98,3.98,3.223,3.757,2.845,3.623,2.618,3.532,2.46,3.46,2.331,3.417,2.254,3.388,2.196,3.37,40,3.955,3.955,3.21,3.73,2.835,3.585,2.592,3.454,2.427,3.395,2.306,3.353,2.218,3.314,2.152,3.296,45,3.95,3.95,3.19,3.73,2.788,3.54,2.56,3.428,2.402,3.345,2.276,3.297,2.188,3.254,2.131,3.223,50,3.935,3.935,3.177,3.653,2.788,3.513,2.538,3.398,2.372,3.32,2.259,3.264,2.17,3.22,2.099,3.181,55,3.9,3.9,3.143,3.67,2.748,3.495,2.508,3.356,2.345,3.28,2.226,3.241,2.139,3.204,2.069,3.148,60,3.88,3.88,3.127,3.65,2.738,3.465,2.496,3.346,2.323,3.273,2.204,3.21,2.114,3.153,2.044,3.104,65,3.88,3.88,3.143,3.623,2.74,3.455,2.492,3.35,2.335,3.252,2.209,3.201,2.12,3.145,2.043,3.094,70,3.875,3.875,3.12,3.623,2.73,3.445,2.482,3.31,2.32,3.232,2.193,3.161,2.1,3.121,2.024,3.079,75,3.895,3.895,3.133,3.597,2.725,3.455,2.482,3.334,2.313,3.228,2.196,3.166,2.103,3.111,2.023,3.068,80,3.87,3.87,3.113,3.61,2.713,3.453,2.474,3.312,2.303,3.22,2.303,3.154,2.088,3.103,2.017,3.052
	  {%NmatUcNt}.fill 30,13.68,13.68,8.17,9.285,6.183,7.873,5.333,7.063,4.768,6.67,4.537,6.37,4.27,6.211,4.104,6.151,35,13.29,13.29,7.87,8.96,6.14,7.607,5.198,6.845,4.59,6.368,4.257,6.04,4.016,5.797,3.841,5.686,40,13.07,13.07,7.625,8.825,5.893,7.337,5.018,6.61,4.428,6.25,4.045,5.898,3.8,5.643,3.644,5.464,45,12.93,12.93,7.74,8.65,5.92,7.197,4.983,6.423,4.394,5.914,4.03,5.598,3.79,5.411,3.595,5.225,50,12.73,12.73,7.56,8.685,5.817,7.303,4.865,6.36,4.306,5.874,3.955,5.583,3.656,5.331,3.498,5.149,55,12.7,12.7,7.435,8.46,5.707,6.977,4.828,6.195,4.244,5.726,3.928,5.408,3.636,5.169,3.424,4.989,60,12.49,12.49,7.4,8.51,5.697,6.987,4.748,6.188,4.176,5.676,3.783,5.338,3.531,5.081,3.346,4.895,65,12.4,12.4,7.32,8.435,5.583,6.853,4.69,6.143,4.188,5.694,3.783,5.3,3.501,5.051,3.31,4.871,70,12.24,12.24,7.17,8.405,5.487,6.88,4.635,6.055,4.098,5.57,3.747,5.285,3.436,5.044,3.261,4.821,75,12.54,12.54,7.225,8.3,5.513,6.86,4.725,6.08,4.168,5.548,3.772,5.213,3.496,4.966,3.266,4.801,80,12.12,12.12,7.095,8.26,5.407,6.783,4.568,5.96,4.096,5.512,3.725,5.163,3.457,4.943,3.233,4.76,30,8.77,8.77,5.395,6.35,4.267,5.473,3.71,5.018,3.354,4.774,3.125,4.608,2.97,4.499,2.875,4.445,35,8.64,8.64,5.29,6.175,4.183,5.333,3.615,4.913,3.276,4.63,3.037,4.443,2.864,4.324,2.753,4.209,40,8.57,8.57,5.26,6.16,4.133,5.26,3.548,4.803,3.202,4.544,2.962,4.338,2.797,4.211,2.676,4.13,45,8.59,8.59,5.235,6.135,4.083,5.207,3.535,4.733,3.178,4.45,2.922,4.268,2.764,4.123,2.643,4.004,50,8.51,8.51,5.22,6.07,4.07,5.19,3.5,4.7,3.136,4.416,2.9,4.218,2.726,4.057,2.593,3.941,55,8.39,8.39,5.125,6.045,3.987,5.09,3.408,4.623,3.068,4.334,2.848,4.16,2.676,3.999,2.556,3.904,60,8.46,8.46,5.125,6,4,5.057,3.415,4.615,3.062,4.314,2.817,4.097,2.643,3.939,2.513,3.823,65,8.49,8.49,5.13,5.98,4.01,5.08,3.435,4.583,3.068,4.274,2.835,4.09,2.647,3.921,2.525,3.808,70,8.37,8.37,5.055,5.915,3.947,5.02,3.37,4.545,3.022,4.256,2.788,4.073,2.629,3.906,2.494,3.786,75,8.42,8.42,5.14,5.92,3.983,5.06,3.408,4.55,3.042,4.244,2.802,4.065,2.637,3.9,2.503,3.768,80,8.4,8.4,5.06,5.93,3.94,5.043,3.363,4.515,3.01,4.216,2.787,4.015,2.627,3.864,2.476,3.746,30,6.84,6.84,4.29,5.08,3.437,4.47,3.008,4.15,2.752,3.994,2.578,3.858,2.457,3.797,2.384,3.728,35,6.81,6.81,4.225,5.05,3.393,4.41,2.958,4.1,2.696,3.898,2.508,3.763,2.387,3.671,2.3,3.606,40,6.76,6.76,4.235,5,3.373,4.377,2.933,4.02,2.66,3.838,2.483,3.708,2.353,3.599,2.26,3.534,45,6.76,6.76,4.225,5.02,3.33,4.347,2.893,3.983,2.638,3.772,2.458,3.647,2.327,3.541,2.238,3.461,50,6.74,6.74,4.19,4.94,3.333,4.313,2.873,3.973,2.614,3.746,2.435,3.6,2.309,3.507,2.205,3.421,55,6.7,6.7,4.155,4.925,3.28,4.273,2.843,3.92,2.578,3.71,2.393,3.583,2.27,3.486,2.181,3.398,60,6.7,6.7,4.145,4.95,3.27,4.26,2.838,3.923,2.568,3.712,2.385,3.565,2.253,3.436,2.155,3.353,65,6.74,6.74,4.175,4.93,3.3,4.25,2.843,3.923,2.574,3.682,2.397,3.543,2.256,3.43,2.156,3.334,70,6.67,6.67,4.125,4.88,3.25,4.237,2.818,3.88,2.552,3.648,2.363,3.51,2.233,3.407,2.138,3.325,75,6.72,6.72,4.15,4.885,3.277,4.243,2.838,3.898,2.558,3.654,2.38,3.515,2.244,3.397,2.134,3.313,80,6.72,6.72,4.135,4.895,3.26,4.247,2.823,3.885,2.548,3.644,2.355,3.5,2.236,3.381,2.129,3.289
	  {%NmatUcRt}.fill 30,10.2,10.2,7.593,8.35,6.428,7.505,5.666,6.988,5.205,6.64,4.85,6.473,4.689,6.358,4.49,6.328,35,9.975,9.975,7.477,8.213,6.328,7.408,5.654,6.926,5.147,6.617,4.849,6.511,4.629,5.698,4.489,5.064,40,9.575,9.575,7.207,7.86,5.98,6.973,5.258,6.526,4.763,6.2,4.427,5.837,4.154,5.699,3.971,5.486,45,9.555,9.555,7.133,7.82,5.878,6.87,5.15,6.28,4.628,5.865,4.251,5.596,3.998,5.463,3.829,5.313,50,9.32,9.32,7.017,7.727,5.805,6.79,5.05,6.182,4.557,5.793,4.214,5.52,3.983,5.345,3.762,5.172,55,9.3,9.3,6.893,7.537,5.678,6.578,4.99,6.018,4.455,5.615,4.111,5.329,3.87,5.171,3.643,5.021,60,9.245,9.245,6.78,7.377,5.62,6.503,4.928,5.95,4.412,5.545,4.013,5.269,3.775,5.086,3.584,4.922,65,8.96,8.96,6.707,7.36,5.545,6.453,4.848,5.842,4.347,5.552,4.02,5.263,3.758,5.04,3.557,4.902,70,8.89,8.89,6.577,7.313,5.448,6.435,4.76,5.798,4.293,5.46,3.966,5.234,3.72,5.004,3.509,4.808,75,8.905,8.905,6.613,7.253,5.505,6.298,4.808,5.786,4.3,5.377,3.984,5.153,3.728,4.954,3.511,4.789,80,6.695,6.695,5.157,5.917,4.358,5.393,3.908,5.004,3.602,4.787,3.351,4.587,3.173,4.485,3.021,4.35,30,7.04,7.04,5.377,5.963,4.535,5.415,4.048,5.09,3.715,4.878,3.504,4.743,3.326,4.653,3.194,4.604,35,6.9,6.9,5.233,5.777,4.433,5.245,3.936,4.918,3.578,4.668,3.353,4.5,3.174,4.383,3.057,4.319,40,6.87,6.87,5.18,5.733,4.36,5.138,3.85,4.782,3.512,4.587,3.257,4.431,3.07,4.309,2.933,4.224,45,6.75,6.75,5.13,5.68,4.335,5.078,3.822,4.714,3.47,4.47,3.211,4.309,3.025,4.198,2.899,4.087,50,6.685,6.685,5.043,5.607,4.225,5.03,3.73,4.666,3.383,4.432,3.149,4.293,2.975,4.143,2.832,4.012,55,6.66,6.66,5.013,5.547,4.183,4.955,3.692,4.582,3.358,4.365,3.131,4.206,2.946,4.065,2.791,3.95,60,6.63,6.63,4.98,5.527,4.18,4.938,3.684,4.584,3.323,4.333,3.086,4.154,2.9,3.999,2.756,3.892,65,6.55,6.55,4.95,5.467,4.123,4.903,3.626,4.538,3.3,4.28,3.063,4.123,2.88,3.978,2.73,3.879,70,6.53,6.53,4.93,5.457,4.1,4.9,3.6,4.512,3.272,4.272,3.043,4.1,2.86,3.951,2.711,3.842,75,6.58,6.58,4.937,5.443,4.12,4.855,3.624,4.488,3.298,4.26,3.054,4.079,2.874,3.914,2.718,3.807,80,4.725,4.725,3.74,4.303,3.235,4.053,2.92,3.838,2.688,3.698,2.55,3.606,2.431,3.518,2.336,3.458,30,5.785,5.785,4.427,4.957,3.77,4.535,3.378,4.274,3.097,4.118,2.907,4.01,2.781,3.941,2.681,3.887,35,5.69,5.69,4.38,4.867,3.698,4.42,3.29,4.176,3.035,3.997,2.831,3.879,2.685,3.785,2.578,3.71,40,5.68,5.68,4.343,4.823,3.663,4.378,3.264,4.094,2.985,3.918,2.781,3.813,2.634,3.719,2.517,3.65,45,5.625,5.625,4.3,4.78,3.625,4.33,3.226,4.054,2.95,3.862,2.75,3.739,2.606,3.644,2.484,3.57,50,5.57,5.57,4.23,4.74,3.573,4.288,3.174,4.004,2.905,3.822,2.703,3.697,2.55,3.609,2.44,3.523,55,5.57,5.57,4.23,4.73,3.553,4.238,3.132,3.956,2.868,3.782,2.674,3.659,2.538,3.56,2.42,3.481,60,5.555,5.555,4.203,4.693,3.54,4.235,3.13,3.968,2.852,3.773,2.653,3.637,2.51,3.519,2.392,3.444,65,5.51,5.51,4.187,4.66,3.535,4.208,3.122,3.942,2.848,3.743,2.647,3.603,2.499,3.49,2.379,3.406,70,5.53,5.53,4.173,4.647,3.505,4.198,3.098,3.92,2.832,3.738,2.631,3.589,2.485,3.473,2.363,3.394,75,5.53,5.53,4.193,4.647,3.505,4.213,3.11,3.9,2.832,3.717,2.636,3.579,2.486,3.469,2.372,3.37,80,3.87,3.87,3.113,3.61,2.713,3.453,2.474,3.312,2.303,3.22,2.18,3.154,2.088,3.103,2.017,3.052
	  {%NmatUcUt}.fill 30,18.56,18.56,10.605,11.65,7.977,9.413,6.643,8.313,5.856,7.578,5.347,7.242,5.046,6.93,4.779,6.821,35,18.02,18.02,10.365,11.295,7.643,9.063,6.38,7.73,5.604,7.172,5.095,6.77,4.704,6.537,4.459,6.206,40,17.91,17.91,10.15,11.23,7.527,8.803,6.238,7.74,5.376,7.092,4.885,6.55,4.527,6.263,4.31,5.965,45,17.5,17.5,9.89,10.965,7.317,8.72,6.053,7.458,5.224,6.696,4.715,6.293,4.364,6.006,4.109,5.785,50,17.53,17.53,9.895,10.965,7.337,8.643,5.995,7.335,5.184,6.684,4.672,6.232,4.31,5.881,4.055,5.64,55,17.48,17.48,9.8,10.675,7.227,8.34,5.955,7.225,5.108,6.494,4.608,5.977,4.23,5.713,3.955,5.474,60,17.02,17.02,9.585,10.42,7.057,8.243,5.835,7.108,5.066,6.394,4.505,5.92,4.117,5.597,3.87,5.338,65,16.85,16.85,9.475,10.515,7.013,8.23,5.795,7.053,4.974,6.378,4.482,5.923,4.111,5.586,3.835,5.339,70,16.66,16.66,9.37,10.32,6.873,8.163,5.663,6.953,4.922,6.328,4.428,5.898,4.07,5.534,3.774,5.248,75,16.61,16.61,9.325,10.325,6.93,8.027,5.698,6.97,4.932,6.224,4.393,5.788,4.06,5.459,3.768,5.229,80,16.6,16.6,9.17,10.24,6.73,8.053,5.62,6.908,4.89,6.164,4.375,5.703,4,5.397,3.728,5.16,30,12.74,12.74,7.36,8.265,5.55,6.747,4.683,5.98,4.154,5.54,3.818,5.253,3.576,5.065,3.394,4.939,35,12.58,12.58,7.21,8.055,5.457,6.57,4.568,5.795,4.036,5.304,3.673,5.002,3.426,4.79,3.251,4.64,40,12.51,12.51,7.135,7.98,5.387,6.437,4.51,5.643,3.958,5.226,3.577,4.923,3.327,4.7,3.121,4.564,45,12.4,12.4,7.08,7.91,5.36,6.373,4.45,5.56,3.89,5.104,3.532,4.8,3.267,4.584,3.091,4.413,50,12.17,12.17,6.985,7.86,5.247,6.303,4.368,5.545,3.834,5.064,3.48,4.782,3.229,4.536,3.039,4.339,55,12.17,12.17,6.93,7.785,5.19,6.223,4.313,5.425,3.794,4.986,3.442,4.69,3.197,4.46,2.989,4.271,60,12.2,12.2,6.905,7.735,5.19,6.2,4.298,5.445,3.772,4.956,3.407,4.632,3.137,4.393,2.956,4.23,65,11.96,11.96,6.89,7.66,5.137,6.173,4.268,5.415,3.732,4.92,3.372,4.613,3.137,4.363,2.924,4.206,70,12,12,6.86,7.645,5.11,6.19,4.235,5.363,3.72,4.904,3.368,4.59,3.107,4.343,2.913,4.168,75,12.08,12.08,6.88,7.675,5.14,6.153,4.253,5.333,3.724,4.88,3.382,4.567,3.111,4.31,2.915,4.143,80,12.06,12.06,6.82,7.67,5.067,6.103,4.203,5.32,3.678,4.84,3.335,4.535,3.077,4.284,2.885,4.111,30,10.34,10.34,6.01,6.78,4.577,5.6,3.868,4.965,3.43,4.624,3.157,4.412,2.977,4.26,2.843,4.16,35,10.24,10.24,5.95,6.68,4.517,5.48,3.8,4.888,3.374,4.512,3.087,4.277,2.879,4.114,2.729,3.985,40,10.16,10.16,5.915,6.63,4.477,5.42,3.76,4.795,3.334,4.438,3.032,4.213,2.831,4.04,2.668,3.92,45,10.15,10.15,5.88,6.64,4.437,5.377,3.74,4.78,3.298,4.378,3.012,4.147,2.796,3.97,2.635,3.838,50,10.02,10.02,5.78,6.54,4.38,5.35,3.673,4.715,3.24,4.35,2.95,4.11,2.75,3.944,2.59,3.789,55,10.11,10.11,5.8,6.515,4.37,5.303,3.64,4.67,3.21,4.294,2.927,4.068,2.724,3.893,2.573,3.76,60,10.03,10.03,5.765,6.5,4.35,5.283,3.645,4.678,3.2,4.31,2.912,4.047,2.709,3.856,2.551,3.716,65,9.97,9.97,5.755,6.47,4.353,5.257,3.638,4.643,3.196,4.262,2.897,4.022,2.69,3.83,2.531,3.685,70,10.02,10.02,5.765,6.455,4.33,5.243,3.615,4.635,3.182,4.258,2.893,4.008,2.683,3.807,2.519,3.669,75,10.03,10.03,5.765,6.47,4.323,5.273,3.618,4.63,3.182,4.248,2.89,3.993,2.681,3.8,2.53,3.648,80,9.96,9.96,5.725,6.45,4.307,5.223,3.588,4.605,3.16,4.23,2.867,3.975,2.657,3.776,2.504,3.631
	  
	  
	  %Nuygunmatrix=@getnextname("ZZ__Nuygunmatrix")
	  matrix {%Nuygunmatrix}
	  {%Nuygunmatrix}={%N{%VarPesMat}}
	      if(!dataSay<33) then
		!NColOrd=1
		else if(!dataSay<38) then
		  !NColOrd=2
		  else  if(!dataSay<43) then
		    !NColOrd=3
		    else  if(!dataSay<48) then
		      !NColOrd=4
		      else  if(!dataSay<53) then
			!NColOrd=5
			else  if(!dataSay<58) then
			  !NColOrd=6
			  else  if(!dataSay<63) then
			    !NColOrd=7
			    else  if(!dataSay<68) then
			      !NColOrd=8
			      else  if(!dataSay<73) then
				!NColOrd=9
				else  if(!dataSay<78) then
				!NColOrd=10
				else 
				!NColOrd=11
				endif 
			      endif
			    endif 
			  endif
			endif 
		      endif
		    endif 
		  endif
		endif 
	      endif

	      
	!Nsira=(!sig-1)*11+!NColOrd
	!NSatir=(!n_var+!a_Lvars)*2 'for keeping longrun asymmetry be correct F Value 
	!NlowF={%Nuygunmatrix}( !NSatir,!Nsira)
	!NhighF={%Nuygunmatrix}(!NSatir+1,!Nsira)
		call TabloOzetEkle("Narayan I(0) & I(1) "  , @str(!NlowF)+" & " +@str(!NhighF),"")
		if(!WaldF >  !NhighF ) then
		      %yaziSonuc=" There is   cointegration"
		       !renk=1
		endif
		if(!WaldF <  !NlowF  ) then
		      %yaziSonuc=" There is not any cointegration"
		      !renk=2
		endif
		if((!WaldF >  !NlowF) and (!WaldF <  !NhighF )  ) then
		      %yaziSonuc="There is not any way to test cointegration."
		      !renk=3
		endif
		call TabloRenkEkle( "Cointegration result (Narayan)" , %yaziSonuc ,  !renk)
		

endif
endsub


subroutine PesaranTable(  )
if !ifVarLar=1 then

	  %matNcNt=@getnextname("ZZ__P_NcNt") 'no intercept No trend
	  %matRcNt=@getnextname("ZZ__P_RcNt") 'restricted intercept No trend
	  %matUcNt =@getnextname("ZZ__P_UcNt") 'Unrestricted intercept No trend
	  %matUcRt =@getnextname("ZZ__P_UcRt")'Unrestricted intercept ristricted trend
	  %matUcUt =@getnextname("ZZ__P_UcUt")'Unrestricted intercept unristricted trend
	  matrix(9,11) {%matNcNt}
	  matrix(9,11) {%matRcNt}
	  matrix(9,11) {%matUcNt}
	  matrix(9,11) {%matUcRt}
	  matrix(9,11) {%matUcUt}
	  {%matNcNt}.fill 0,3.00,3.00,4.20,4.20,5.47,5.47,7.17,7.17,1,2.44,3.28,3.15,4.11,3.88,4.92,4.81,6.02,2,2.17,3.19,2.72,3.83,3.22,4.50,3.88,5.30,3,2.01,3.10,2.45,3.63,2.87,4.16,3.42,4.84,4,1.90,3.01,2.26,3.48,2.62,3.90,3.07,4.44,5,1.81,2.93,2.14,3.34,2.44,3.71,2.82,4.21,6,1.75,2.87,2.04,3.24,2.32,3.59,2.66,4.05,7,1.70,2.83,1.97,3.18,2.22,3.49,2.54,3.91,8,1.66,2.79,1.91,3.11,2.15,3.40,2.45,3.79,9,1.63,2.75,1.86,3.05,2.08,3.33,2.34,3.68,10,1.60,2.72,1.82,2.99,2.02,3.27,2.26,3.60
	  {%matRcNt}.fill 0,3.80,3.80,4.60,4.60,5.39,5.39,6.44,6.44,1,3.02,3.51,3.62,4.16,4.18,4.79,4.94,5.58,2,2.63,3.35,3.10,3.87,3.55,4.38,4.13,5.00,3,2.37,3.20,2.79,3.67,3.15,4.08,3.65,4.66,4,2.20,3.09,2.56,3.49,2.88,3.87,3.29,4.37,5,2.08,3.00,2.39,3.38,2.70,3.73,3.06,4.15,6,1.99,2.94,2.27,3.28,2.55,3.61,2.88,3.99,7,1.92,2.89,2.17,3.21,2.43,3.51,2.73,3.90,8,1.85,2.85,2.11,3.15,2.33,3.42,2.62,3.77,9,1.80,2.80,2.04,3.08,2.24,3.35,2.50,3.68,10,1.76,2.77,1.98,3.04,2.18,3.28,2.41,3.61
	  {%matUcNt}.fill 0,6.58,6.58,8.21,8.21,9.80,9.80,11.79,11.79,1,4.04,4.78,4.94,5.73,5.77,6.68,6.84,7.84,2,3.17,4.14,3.79,4.85,4.41,5.52,5.15,6.36,3,2.72,3.77,3.23,4.35,3.69,4.89,4.29,5.61,4,2.45,3.52,2.86,4.01,3.25,4.49,3.74,5.06,5,2.26,3.35,2.62,3.79,2.96,4.18,3.41,4.68,6,2.12,3.23,2.45,3.61,2.75,3.99,3.15,4.43,7,2.03,3.13,2.32,3.50,2.60,3.84,2.96,4.26,8,1.95,3.06,2.22,3.39,2.48,3.70,2.79,4.10,9,1.88,2.99,2.14,3.30,2.37,3.60,2.65,3.97,10,1.83,2.94,2.06,3.24,2.28,3.50,2.54,3.86
	  {%matUcRt}.fill 0,5.37,5.37,6.29,6.29,7.14,7.14,8.26,8.26,1,4.05,4.49,4.68,5.15,5.30,5.83,6.10,6.73,2,3.38,4.02,3.88,4.61,4.37,5.16,4.99,5.85,3,2.97,3.74,3.38,4.23,3.80,4.68,4.30,5.23,4,2.68,3.53,3.05,3.97,3.40,4.36,3.81,4.92,5,2.49,3.38,2.81,3.76,3.11,4.13,3.50,4.63,6,2.33,3.25,2.63,3.62,2.90,3.94,3.27,4.39,7,2.22,3.17,2.50,3.50,2.76,3.81,3.07,4.23,8,2.13,3.09,2.38,3.41,2.62,3.70,2.93,4.06,9,2.05,3.02,2.30,3.33,2.52,3.60,2.79,3.93,10,1.98,2.97,2.21,3.25,2.42,3.52,2.68,3.84
	  {%matUcUt}.fill 0,9.81,9.81,11.64,11.64,13.36,13.36,15.73,15.73,1,5.59,6.26,6.56,7.30,7.46,8.27,8.74,9.63,2,4.19,5.06,4.87,5.85,5.49,6.59,6.34,7.52,3,3.47,4.45,4.01,5.07,4.52,5.62,5.17,6.36,4,3.03,4.06,3.47,4.57,3.89,5.07,4.40,5.72,5,2.75,3.79,3.12,4.25,3.47,4.67,3.93,5.23,6,2.53,3.59,2.87,4.00,3.19,4.38,3.60,4.90,7,2.38,3.45,2.69,3.83,2.98,4.16,3.34,4.63,8,2.26,3.34,2.55,3.68,2.82,4.02,3.15,4.43,9,2.16,3.24,2.43,3.56,2.67,3.87,2.97,4.24,10,2.07,3.16,2.33,3.46,2.56,3.76,2.84,4.10
	  
	  if !sig=1 then
	  !PesaranR=8
	  endif
	  if !sig=2 then
	  !PesaranR=4
	  endif
	  if !sig=3 then
	  !PesaranR=2
	  endif
	    %uygunmatrix=@getnextname("ZZ__uygunmatrix")
	    matrix {%uygunmatrix}
	    {%uygunmatrix}={%{%VarPesMat}}
	  !Pesaran_Knumber=   !n_var+!a_Lvars 'for keeping longrun asymmetry be correct F Value 
	  !lowF={%uygunmatrix}(!PesaranR, !Pesaran_Knumber)
	  !highF={%uygunmatrix}((!PesaranR+1), !Pesaran_Knumber)



	  call TabloOzetEkle("calculated F" , @str(!WaldF),"" )
	  {%OzetTable}.setfont(!tabloOzetSira,B) +b +i -s

	  call TabloOzetEkle("Pesaran I(0) & I(1) "  , @str(!lowF)+" & " +@str(!highF),"")

	  if(!WaldF >  !highF ) then
	    %yaziSonuc=" There is   cointegration"
	    !renk=1
	  endif
	  if(!WaldF <  !lowF  ) then
	  %yaziSonuc=" There is not any cointegration"
	    !renk=2
	  endif
	  if((!WaldF >  !lowF) and (!WaldF <  !highF )  ) then
	  %yaziSonuc="There is not any way to test cointegration." 
	    !renk=3
	  endif
	call  TabloRenkEkle( "Cointegration result (Pesaran)" , %yaziSonuc, !renk)
	  
endif
endsub


subroutine UrootHesapla()
if !ifVarLar=1 then
'------------------------------------------------------------------------------------------'
	%statmsg3="Checking the 1st and 2nd differences Unit root"
	' statusline %statmsg3
	' check for 1st and 2nd diff '
	for !k=1 to !n_var
	%v1=@word(%vars,!k)
	%prompt3="Unfortunelay ,series named"+" "+%v1+" "+"is not stationary with second differencing and ARDL bound approach cann't be applied"
			if !b=1 then
				%urtopt="c"
			else
				%urtopt="n"
			endif
			%urtesttable ="_temp"+%v1+"urt"
		if @isobject(%urtesttable) then 
			%urtesttable = @getnextname(%urtesttable)
		endif
			freeze({%urtesttable}) {%v1}.uroot({%urtst},{%urtopt})
			freeze({%urtesttable}_1d) {%v1}.uroot({%urtst},{%urtopt},dif=1)
			freeze({%urtesttable}_2d) {%v1}.uroot({%urtst},{%urtopt},dif=2)
			if %urtst="adf" or %urtst=%pp then 
					!lm = @val({%urtesttable}_2d(7,4))
					!crit = @val({%urtesttable}_2d(7+!sig,4))
			else
					!lm = @val({%urtesttable}_2d(7,5))
					!crit = @val({%urtesttable}_2d(7+!sig,5))
			endif
			if !lm>!crit then
				@uiprompt(%prompt3)
				stop
			endif
	next
endif
endsub

subroutine   WriteToLog(  string %in )
 if !ifVarLar=1 then 
      if !debug = 1 then
	  if @isobject(%WriteLog) then
	  else
	      %WriteLog= @getnextname("ZZ__WriteLog")
	      text  {%WriteLog}
	  endif
	  !logLine=!logLine+1
	  {%WriteLog}.append  !logLine _____________________________________________
	  {%WriteLog}.append {%in}
	  {%WriteLog}.append  
	  
      endif
 endif	
endsub

