% path = 'Caltech4/Results/';
% % Create path
% if exist(path,'dir') ~= 7
%     mkdir(path);
% end
%     
% [ranking,mAP] = test('Caltech4',400,'grey',0);
% results = construct_name('results',400,'grey',0);
% map = construct_name('map',400,'grey',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'RGB',0);
% results = construct_name('results',400,'RGB',0);
% map = construct_name('map',400,'RGB',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'rgb',0);
% results = construct_name('results',400,'rgb',0);
% map = construct_name('map',400,'rgb',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'opponent',0);
% results = construct_name('results',400,'opponent',0);
% map = construct_name('map',400,'opponent',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'grey',10);
% results = construct_name('results',400,'grey',10);
% map = construct_name('map',400,'grey',10);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'RGB',10);
% results = construct_name('results',400,'RGB',10);
% map = construct_name('map',400,'RGB',10);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'rgb',10);
% results = construct_name('results',400,'rgb',10);
% map = construct_name('map',400,'rgb',10);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',400,'opponent',10);
% results = construct_name('results',400,'opponent',10);
% map = construct_name('map',400,'opponent',10);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',800,'grey',0);
% results = construct_name('results',800,'grey',0);
% map = construct_name('map',800,'grey',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',1600,'grey',0);
% results = construct_name('results',1600,'grey',0);
% map = construct_name('map',1600,'grey',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',2000,'grey',0);
% results = construct_name('results',2000,'grey',0);
% map = construct_name('map',2000,'grey',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% [ranking,mAP] = test('Caltech4',4000,'grey',0);
% results = construct_name('results',4000,'grey',0);
% map = construct_name('map',4000,'grey',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');
% 
% 
% [ranking,mAP] = test('Caltech4',800,'RGB',0);
% results = construct_name('results',800,'RGB',0);
% map = construct_name('map',800,'RGB',0);
% save(strcat(path,results),'ranking');
% save(strcat(path,map),'mAP');

[ranking,mAP] = test('Caltech4',400,'grey',0,0);
results = construct_name('results',400,'grey',0);
results = ['0_',results];
map = construct_name('map',400,'grey',0);
map = ['0_',map];
save(strcat(path,results),'ranking');
save(strcat(path,map),'mAP');

[ranking,mAP] = test('Caltech4',400,'grey',0,2);
results = construct_name('results',400,'grey',0);
results = ['2_',results];
map = construct_name('map',400,'grey',0);
map = ['2_',map];
save(strcat(path,results),'ranking');
save(strcat(path,map),'mAP');

[ranking,mAP] = test('Caltech4',400,'grey',0,3);
results = construct_name('results',400,'grey',0);
results = ['3_',results];
map = construct_name('map',400,'grey',0);
map = ['3_',map];
save(strcat(path,results),'ranking');
save(strcat(path,map),'mAP');

[ranking,mAP] = test('Caltech4',400,'grey',0,1);
results = construct_name('results',400,'grey',1);
results = ['1_',results];
map = construct_name('map',400,'grey',0);
map = ['1_',map];
save(strcat(path,results),'ranking');
save(strcat(path,map),'mAP');