# Project4RT
Swarming with Possibilities: Bifurcation Analysis of Swarming Models

This is the github for my Project supervised by Andrew Krause and Denis Patterson.

It includes my code for the Kuramoto and Vicsek models as well as animations of the models.

The Kuramoto Model 
---------
- A model looking at synchronised oscillators, 
- r is the order parameter
  * 0 - fully unsychronised
  * 1 - fully synchronised
- K is the coupling strength
  * 0 - no coupling
  * 5 - strong coupling

- KuramotoModel = The Kuramoto model; produces graphs : r-t, circle plot, histogram of final phase.

- KuramotoKVals = Runs the Kuramoto model over a range of K values; produces graphs : r-t overlays, r-K.

- KuramotoConstW = Runs the Kuramoto model; produces graphs : Moving circle plot, r-t. Uses PlotCircle and PlotR.

- KuramotoWVals = Runs the Kuramoto model over a range of W values; produces graphs : r-t overlays, r-W.

- PlotCircle and PlotR = The plotting functions for the Kuramoto model, need to be run with the other codes
- KuramotoVideos = function that generates videos of the Kuramoto model in action.

* VIDEOS
  * OpKuramotoK_N___.mp4 - Videos that have the order parameter in the plot, K and N are specified in the file name
  * KuramotoK_N___.mp4 - Videos of the Kuramoto Model with no order parameter, K and N are specified in the file name

The Vicsek Model
---------
- A model looking at the directions of particles in a swarm, 
- psi is the order parameter
  * 0 - incoherent
  * 1 - collectivly aligned
- eta is the noise intensity
  * 0 - No noise
  * 1 - Lots of noise

- VicsekModel = The Vicsek model; produces graphs : Moving plot, psi-t plot.
- IntrinsicVicsek - function to run with VicsekModel for the Intrinsic Noise Model
- ExtrinsicVicsek - function to run with VicsekModel for the Extrinsic Noise Model

- VicsekEtaVals = Runs the Vicsek model over a range of eta values; produces graphs : psi-eta, psi-t overlays.
- IntrinsicVicsekEtaVals - function to run with VicsekEtaVals for the Intrinsic Noise Model
- ExtrinsicVIcsekEtaVals - function to run with VicsekEtaVals for the Extrinsic Noise Model

- RadiusEtaVicsek = Runs the Vicsek model over a range of eta values and radius values; produces a heatmap.

- PlotVicasekMove = The plotting function for the Vicsek model, needs to be run with the other codes

- TimeCapture = function that takes snapshots of the Vicsek model at T = 0, T = 300, T = 3000. Can be run for Intrinsic or Extrinsic noise.

- ExtrinsicVideos and IntrinsicVideos = functions that generate videos of the Vicsek model in action.

* VIDEOS
  * VicsekEta__.mp4 - Videos of the Vicsek model, Eta is specified in the file name
