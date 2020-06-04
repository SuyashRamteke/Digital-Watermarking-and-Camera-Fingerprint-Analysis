# Digital-Watermarking-and-Camera-Fingerprint-Analysis
This is a project that I did as a part of my course on Detection Theory

1. PRNU pre-processing. The estimated PRNU (color fingerprint) that you already have from a previous assignment also contains, 
besides the PRNU itself, other artifacts that are not unique to each sensor and may be shared among cameras from the same 
manufacturer or cameras sharing the same sensor architecture. It is important to remove these artifacts before attempting to 
identify your images to decrease the probability of false identification for cameras of the same brand or cameras that share 
the same type of sensor.
The most common artifacts are caused by color interpolation and sensor signal transfer and manifest themselves as a non-zero 
bias in column and row averages. Thus, what you need to do is to make sure that the mean value of each row and each column in 
each color channel of K is zero. 
This can be achieved, for example, by first subtracting the mean of each column from all elements in that column and then doing 
the same for the rows. Convince yourself that you will not mess up the columns this way.
Calculate the difference between the original PRNU and the pre-processed one and display as an RGB image ( use Matlab’s imshow(difference,[]) ).

2. The images come from different cameras, have been cropped to different sizes, and exactly two are from your camera. The cropped
part is the “upper left corner.” Thus, use the corresponding part of your PRNU to correlate it with. The supplied function 
‘croscorr2’ needs the fingerprint and the image to be of the same dimensions. The images in the archive are not all of the 
same size, so make sure that your cropped fingerprint dimensions match the analyzed image.

3. Detect your image. Instead of working with RGB channels of the fingerprint separately, convert your cropped fingerprint 
from three RGB channels to a single “gray” fingerprint K 

If you see periodic dots in your fingerprint forming an 88 dot pattern, process your “gray” fingerprint using ‘zeromean88’ 
also available from Blackboard\Assignments: K = zeromean88(K).
For each image Ik from the archive, calculate its noise residual using the Wiener filter, Wk = Ik – F(Ik). 
(Remember to cast Ik to double.) Do the filtering for each color channel separately and then combine the residuals using the 
same linear combination as in (1) to form one “grayscale” residual. Then, convert all images Ik to grayscale.

4. Use the PCE ratio to establish which image(s) is (are) from your camera. For cross-correlation, use the Matlab script ‘crosscorr2.m’ provided on Blackboard\Assignments. Inspect the code to see how it works, admire it for a while, get a cold beer from your fridge (only if you are 21 or older), and then continue your work. For images from your camera, you should see a peak in the cross- correlation for zero spatial shift (when both the image and the cropped fingerprint are aligned). Then, calculate the PCE as introduced during the lecture. Note, the peak may be “split” into the four corners of your cross-correlation.
You will end up with as many PCE values as there are images in the archive. Plot the values of all
PCEs and include in your report. The largest values of the PCE (should be above 60) should be for
your image(s).

