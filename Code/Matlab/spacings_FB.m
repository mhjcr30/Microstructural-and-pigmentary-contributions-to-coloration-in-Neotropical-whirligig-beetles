%This code is to be used to reproduce results from the Supplementary docs 
%in manuscript Microstructural and pigmentary contributions to coloration
% in Neotropical whirligig beetles (Coleoptera: Gyrinidae)
clear
%This extracts all .csv files in the current folder, which must contain
%the files with the maxima list of each average spectrum and the spectra.
files = dir('*.csv'); 
[d1,d2]=size(files);
K=size(files);
   
% This allows you to choose files, use p=x, where x is an integer
% you choose according to the file you select. For example, in our 
% files, p=1 corresponded to DS-dark maxima and p=5 t GC-dark maxima

p=1; 
    tmp=importdata(files(p).name,',' );
    datos=tmp;
    ds_datmax=datos(:,2);
    ds_lmax=datos(:,1);
p = 5; 
    tmp=importdata(files(p).name,',' );
    datos=tmp;
    gc_datmax=datos(:,2);
    gc_lmax=datos(:,1);

% Now, we extract the spectra from our files.Change the value of p
% accordinly
p=4;
tmp_ds=importdata(files(p).name,',' );
    spec_ds_dark=tmp_ds.data;
p=7;
tmp_gc=importdata(files(p).name,',' );
    spec_gc_dark=tmp_gc.data;
%%    
% We plot the spectra together with the maxima points.Figure S1_1
scatter(ds_lmax,ds_datmax,"filled")
hold
plot(spec_ds_dark(:,1),spec_ds_dark(:,2),"b")
xlim([420,700]);
xlabel("Wavelength (nm)")
ylabel("Reflectance (%)")
box on;
%%
scatter(gc_lmax,gc_datmax,"filled")
hold
plot(spec_gc_dark(:,1),spec_gc_dark(:,2),"b")
xlim([420,700]);
xlabel("Wavelength (nm)")
ylabel("Reflectance (%)")
box on;
% Calculation of the spacing according to eq. (2) in the manuscript
%%
[L,J]=size(gc_lmax);
GCdelta=zeros(L-1,1);
for i=1:L-1
    GCdelta(i)=gc_lmax(i)*gc_lmax(i+1)/1.6/2/(gc_lmax(i)-gc_lmax(i+1))/1000;
end
%%
[L,J]=size(ds_lmax);
DSdelta=zeros(L-1,1);
for i=1:L-1
    DSdelta(i)=ds_lmax(i)*ds_lmax(i+1)/1.6/2/(ds_lmax(i)-ds_lmax(i+1))/1000;
end
% We export the data.
writematrix(DSdelta,"DS-spacing.csv")
writematrix(GCdelta,"GC-spacing.csv")

