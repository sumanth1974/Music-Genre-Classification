foldername = 'Sample_All';                                      %Take 10 files from each genre and place them in Sample_All folder
 files      = dir(foldername);
 length(files)
 A=zeros(100,1);                                                %Matrix for ZCR
 Cent_Matrix=zeros(100,1);                                      %Matrix for Spectral Centriod
 genre=zeros(100,1);
 mfcc_matrix=zeros(100,13);                                     %Matrix for mfcc coeffiecients
 
 a=1;                                                       %Index of ZCR matrix a,b are used
 i=1;
 part= (length(files)-2);
 
 for k=1:(part+2)
    
    if ~files(k).isdir                                    % ignore directories[To ignore . ,.. directories.That's why,102 files ]
         filename = fullfile(foldername,files(k).name);   % build the file name
         fid = fopen(filename);                           % open the file
         [x,fs]=audioread(filename);
         filename                                         %To print the file names 
         y=ZCR(x)                                         %finding Zero Crossing Rate(ZCR)
         Cent=demoSpectralCentroidSpread_frame(x, fs)      %Spectral centriod
         [FFT, Freq] = getDFT(x, fs);
         windowLength = length(x);
         mfccParams = feature_mfccs_init(windowLength, fs);
         ceps = feature_mfccs(FFT, mfccParams);             %for mfcc coeffiecients
         %disp(mfccParams);
         disp('mfcc coefficients : ');
         disp(ceps);
         ceps_tran=transpose(ceps)
         
         A(a,1)=y;
         Cent_Matrix(a,1)=Cent;
         for i = 1:13
             mfcc_matrix(a,i) =ceps_tran(i); 
         end
         
         a=a+1
         i=i+1
         
         if i == 14
             i=1
         end
         
         if fid>0
             % do stuff with file contents
             % close the file
             fclose(fid);
         end
    end
 end
 

ZCR_Matrix=A                  

Cent_Matrix;

SpectralCentriod_Matrix=Cent_Matrix 

mfcc_matrix

whole_matrix=[ZCR_Matrix SpectralCentriod_Matrix mfcc_matrix]              %Whole matrix contains all 15(ZCR + Spectral Centriod +Mfcc Coeff.) features.