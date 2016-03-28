function full_name = construct_name(name,vocab_size,type,step,kernel)
    full_name = [name,'_',num2str(vocab_size),'_',type,'_',num2str(step),'_',num2str(kernel),'.mat'];
end