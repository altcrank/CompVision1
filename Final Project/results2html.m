function results2html(img_per_class,vocab_size,type,step,kernel)
    NUMBER_OF_CLASSES = 4;
    SIZE_TEST_SET = 200;
    CLASS_NAMES = {'Airplanes','Cars','Faces','Motorcycles'};
    
    % load test results
    result_path = 'Caltech4/Results/';
    mAP = load([result_path,'map_',num2str(vocab_size),'_',type,'_',num2str(step),'_',num2str(kernel),'.mat']);
    ranking = load([result_path,'results_',num2str(vocab_size),'_',type,'_',num2str(step),'_',num2str(kernel),'.mat']);
  
    % svm kernel used for file name
    if ~kernel
        kernel_name = 'linear';
    elseif kernel == 1
        kernel_name = 'polynomial';
    elseif kernel == 2
        kernel_name = 'radial';
    elseif kernel == 3
        kernel_name = 'sigmoid';
    end
    
    % sift method used for file name
    if ~step
        sift = 'sparse';
    else
        sift = 'dense';
    end
    
    % HTML
    html_path = ['/HtmlResults/NewTests/',sift,num2str(vocab_size),type,kernel_name,'.html'];  
    f = fopen(html_path, 'w');
    fprintf(f,'<!DOCTYPE html> \n <html lang="en"> \n <head> \n <meta charset="utf-8"> \n <title>Image list prediction</title> \n <style type="text/css"> \n img { \n width:200px; \n } \n </style> \n </head> \n <body> \n');
    fprintf(f,'<h2> Georgi Terziev, Ilse van der Linden </h2> \n');
    fprintf(f,'<h1>Settings</h1> \n <table>  \n');
    if ~step
        fprintf(f,'<tr><th>SIFT step size</th><td> - px</td></tr>  \n');
        fprintf(f,'<tr><th>SIFT block sizes</th><td> 4x4 pixels</td></tr>  \n');
        fprintf(f,'<tr><th>SIFT method</th><td>Keypoint-SIFT</td></tr>  \n');
    else
        fprintf(f,'<tr><th>SIFT step size</th><td> %d px</td></tr>  \n', step);
        fprintf(f,'<tr><th>SIFT block sizes</th><td> 3x3 pixels</td></tr>  \n');
        fprintf(f,'<tr><th>SIFT method</th><td>Dense-SIFT</td></tr>  \n');
    end
    fprintf(f,'<tr><th>Color space</th><td> %s </td></tr>  \n', type);
    fprintf(f,'<tr><th>Vocabulary size</th><td> %d words</td></tr>  \n', vocab_size);
    fprintf(f,'<tr><th>Vocabulary fraction</th><td> %d </td></tr>  \n', (img_per_class * 4));
    fprintf(f,'<tr><th>SVM training data</th><td> %d positive, %d negative per class</td></tr>  \n', img_per_class,(img_per_class * 3));
    fprintf(f,'<tr><th>SVM kernel type</th><td> %s </td></tr> \n', kernel_name);
    fprintf(f,'</table> \n');
    fprintf(f,'<h1>Prediction lists (MAP: %4.3f )</h1> \n', mean(mAP.mAP));
    fprintf(f,'<table> \n <thead> \n <tr> \n');
    for class = 1:NUMBER_OF_CLASSES
        fprintf(f,'<th> %s (AP: %4.3f )</th> \n', CLASS_NAMES{class}, mAP.mAP(class));
    end  
    fprintf(f,'</tr> \n </thead> \n <tbody> \n');
    % html for images
    for rank = 1:SIZE_TEST_SET
        fprintf(f,'<tr> \n');
        for class = 1:NUMBER_OF_CLASSES
            img_path = ['../../../', ranking.ranking{1,class}{rank,1}];
            fprintf(f,'<td><img src= %s /></td> \n', img_path);
        end
        fprintf(f,'</tr> \n');
    end   
    fprintf(f,'</tbody> \n </table> \n </body> \n </html>');
    fclose(f);
end