function Settings = LoadSettings(WBVconfig)
%LOADSETTINGS Load WBV_Calculator Settings 
% Input:
%   WBVconfig: full filepath of the configuration file
%
% Output:
%   Settings: a structure containing Settings

% check whether the config folder exists, if not create it
[configDir,~,~] = fileparts(WBVconfig);
if ~isfolder(configDir)
    mkdir(configDir);
end


% check if the main config file exist and load last settings
if isfile(WBVconfig)
    imptOpt=detectImportOptions(WBVconfig,'FileType','text');
    varNamesOrig=string(imptOpt.VariableNames);
    strVarNames=["CWAFile","CALFile"];
  
    varTypesOrig=string(imptOpt.VariableTypes);
    [~,idStrVars,~]=intersect(varNamesOrig,strVarNames);
    varTypesOrig(idStrVars)="string";
    imptOpt.VariableTypes=varTypesOrig;
    Settings=table2struct(readtable(WBVconfig,imptOpt));
else
    % otherwise create an empty Settings structure
    Settings = struct;
end

% load filenames and paths settings
if ~isfield(Settings,'CWAFile'),Settings(1).CWAFile = getenv('USERPROFILE');end
if ~isfield(Settings,'CALFile'),Settings(1).CALFile = fullfile(getenv('USERPROFILE'),'Documents','DeviceCal.csv');end

