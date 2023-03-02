function Settings = LoadSettings(WBVconfig)
%LOADSETTINGS Load WBV_Calculator Settings 
% Input:
%   WBVconfig: full filepath of the configuration file
%
% Output:
%   Settings: a structure containing Settings
% Copyright (c) 2021, Pasan Hettiarachchi .
% All rights reserved.
% 

% Redistribution and use in source and binary forms, with or without 
% modification, are permitted provided that the following conditions are met: 
% 1. Redistributions of source code must retain the above copyright notice, 
%    this list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright notice, 
%    this list of conditions and the following disclaimer in the documentation 
%    and/or other materials provided with the distribution.
% 3. Neither the name of the copyright holder nor the names of its contributors
%    may be used to endorse or promote products derived from this software without
%    specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.  

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

