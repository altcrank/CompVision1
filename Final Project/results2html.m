function results2html(ranking,mAP,class_names,vocab_size,type,step)
    NUMBER_OF_CLASSES = 4;
    SIZE_TEST_SET = 200;
    f = fopen('results.html', 'w');
    fprintf(f,'<!DOCTYPE html> \n <html lang="en"> \n <head> \n <meta charset="utf-8"> \n <title>Image list prediction</title> \n <style type="text/css"> \n img { \n width:200px; \n } \n </style> \n </head> \n <body> \n');
    fprintf(f,'<h2> Georgi Terziev, Ilse van der Linden </h2> \n');
    fprintf(f,'<h1>Settings</h1> \n <table>  \n');
    if ~step
        fprintf(f,'<tr><th>SIFT step size</th><td> - px</td></tr>  \n');
    else
        fprintf(f,'<tr><th>SIFT step size</th><td> %d px</td></tr>  \n', step);
    end
    %%% Block size is SIFT window size??
    fprintf(f,'<tr><th>SIFT block sizes</th><td> 15 pixels</td></tr>  \n'); 
    if ~step
        fprintf(f,'<tr><th>SIFT method</th><td>Keypoint-SIFT</td></tr>  \n');
    else
        fprintf(f,'<tr><th>SIFT method</th><td>Dense-SIFT</td></tr>  \n');
    end
    fprintf(f,'<tr><th>Color space</th><td> %s </td></tr>  \n', type);
    fprintf(f,'<tr><th>Vocabulary size</th><td> %d words</td></tr>  \n', vocab_size);
    %%% how many examples used for building vocabulary??
    fprintf(f,'<tr><th>Vocabulary fraction</th><td>XXX</td></tr>  \n');
    %%% TODO: fprintf(f,'<tr><th>SVM training data</th><td>XXX positive, XXX negative
    %per class</td></tr>  \n');
    %%% SVM Kernel type always linear??
    fprintf(f,'<tr><th>SVM kernel type</th><td> Linear </td></tr> \n');
    fprintf(f,'</table> \n');
    fprintf(f,'<h1>Prediction lists (MAP: %4.3f )</h1> \n', mean(mAP));
    fprintf(f,'<table> \n <thead> \n <tr> \n');
    for class = 1:NUMBER_OF_CLASSES
        fprintf(f,'<th> %s (AP: %4.3f )</th> \n', class_names{class}, mAP(class));
    end  
    fprintf(f,'</tr> \n </thead> \n <tbody> \n');
    
    for rank = 1:SIZE_TEST_SET
        fprintf(f,'<tr> \n');
        for class = 1:NUMBER_OF_CLASSES
            %%% Not sure if correct indexing
            fprintf(f,'<td><img src= %s /></td> \n', ranking{class,rank});
        end
        fprintf(f,'</tr> \n)');
    end   
    fprintf(f,'</tbody> \n </table> \n </body> \n </html>');
    fclose(f);
end