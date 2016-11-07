function [y, info] = wvfreadall(filename, Group, Trace, Block, varargin)
% function [y, info] = wvfreadall(filename, Group, Trace, Block, datapoints, step, startind)
%
% loads YT-waveform data from *.wvf file saved by Yokogawa DL 750, DL 1600 series
% and DL 7440 Oscilloscopes into the structure y. 
% Format of the structure:
%    y.Group<group index>.Trace<trace index>.Block<block index>:     data
%    y.Group<group index>.Trace<trace index>.t                       time
%    y.Group<group index>.Trace<trace index>.ind_over                (a)
%    y.Group<group index>.Trace<trace index>.ind_under               (a)
%    y.Group<group index>.Trace<trace index>.ind_illegal             (a)
%
%        (a): indices of overranged data points outside the upper / lower
%             limit of the TDS AD converter and indices of illegal values.
%             Just as t, they are not saved block by block, but only per 
%             trace.
%
% optional output info: returns information on the wvf file in "info"
% (structure)
%
% optional input arguments:
%   - Group,Trace, Block
%        specifies which trace should be read.
%        They can be provided as a matrix, e.g. [2, 4:6] 
%        if only Block is omitted, read all blocks of specified traces and
%        groups
%        if only Trace is omitted, read all traces of the specified group
%        if Group is also omitted, read all data in the wvf file
%        If empty matrix [] is provided as input, all data of the field
%        (e.g. group, trace, or block) is read. This can be combined
%        arbitrarily between groups, traces and blocks.
%
% optional input parameters:
%   - datapoints:   number of data points to be read
%   - step:         only every step-th data point is read, the others are
%                   disregarded
%   - startind:     start reading from the startind-th data point
%   read data points startind:step:datapoints 
%   from the wvf file. if datapoints is omitted, all data are read, if step 
%   is omitted, step=1. If startind omitted, startind=1
%   CAUTION: These parameters apply to all data read from the different
%   groups/traces/blocks, and one should be careful with its use since
%   different groups/traces/blocks might require different step arguments
%   to achieve sensible results. In such cases, use wvfreadall.m without
%   the critical input parameter or use wvfreadb.m in a loop etc. directly
%   to provide the critical input parameter (i.e. datapoints, step or 
%   startind) individually per group/trace/block.
%
%
% Reading of *.wvf files written by other than the above Oscilloscopes may
% result in errors, because I could not test with those wvf files.
%
% Author:
% Erik Benkler
% Physikalisch-Technische Bundesanstalt
% Section 4.53: Optical Femtosecond Metrology
% Bundesallee 100
% D-38116 Braunschweig
% Germany
% Erik.Benkler a t ptb.de
%
% The implementation is based on Yokogawa ASCII header file format
% description in Appendix 3 of the DL 1640 user manual and on the
% Yokogawa Technical Information TI 7000-21 E 1998 1 3rd edition:
% "Understanding the structure of Binary data (xxxxxxxx.WVF) file created
% by the DL, AR series"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% current state of the project and change history:
%
% Version 1.0, May 21, 2007: first released version tested with DL 1600 scopes
% requires function stringparse.m by E. Benkler
%
% Version 1.1, July 31, 2008:
% (a) adapted to work with DL 7440 scopes (writes empty lines at different positions of header file)
% (b) requires functions stringparse.m and fileparse.m by E. Benkler
%
% Version 1.2, September 24, 2008
% (a) added compatibility with file format written by DL750 scopes
% (b) moved stringparse and fileparse functions to hdrread.m (old
% stringparse.m and fileparse.m should be deleted from Matlab path)
%
% Version 1.3, January 26, 2009
% (a) removed a bug (missing initialization of variable "rep" when using
%     step parameter (thanks to Peter Noronha for pointing out this bug)
% (b) improved performance when using step argument by preallocating data
%     array (thanks to Peter Noronha for pointing out this improvement)
% (c) added support for logic signals (raw binary format) written by DL750
%     model only.
% (d) changed the way the header file is parsed. Only if an entry really
%     exists and makes sense (e.g., a question mark as the entry
%     VPlusOverData does not make sense), the corresponding info structure
%     element is generated.
% (e) print out warning concerning wrong values only if output of these
%     values is requested by presence of the corresponding output argument
%     of wvfread
% (f) info structure added as optional output argument of wvfread
% (g) The $PrivateInfo is not read any more, because this contains too much
%     instrument-specific stuff which is probably not really necessary.
%     Please inform the author if you need reading of the $PrivateInfo
% (h) Error message if there are multiple blocks in the wvf file
% (i) Replaced "eval" by using dynamic structure entries
%
% Version 1.4, April 30, 2009
% (a) improved file name checking (re-submitted to FileExchange)
%
% Version 1.5, June 04, 2009: Major changes!
% zip-file contents: hdrread.m, wvfread.m, wvfreadb.m, wvfreadall.m,
% wvf__logicsignals_example.m
% (a) Added function wvfreadb.m (wvfread with block>1 support)
%     This required modification of the input parameter structure, so, in
%     order to maintain downward compatibility of wvfread.m,  I
%     wrote the new function wvfreadb.m which takes the additional input
%     parameter "Block".
%     wvfread.m is now a wrapper function with its old in- and
%     output structures which calls wvfreadb.m and from here on, all
%     changes are maintained in wvfreadb.m
% (b) Added support for accessing any block in a trace and group:
%     wvfreadb.m can now read any specified block in a trace and group,
%     whereas wvfread.m remains limited to reading of block 1 only.
% (c) Added support for wvf files written in the "Block" format (untested,
%     please report to the author if you can provide a test wvf file in the
%     block format): both wvfread.m and wvfreadb.m now should work with wvf
%     files written in the block format (but wvfread.m is restricted to
%     block number 1, whereas wvfreadb.m can access any specified block)
% (d) Removed a bug in hdrread.m: Entry "TraceName" is now read to
%     tracenummax, not only to Group1.trace1.tracenum(thanks to Frederic
%     Sun and Ronan Danioux for pointing out this bug)
% (e) Removed function "assign"
% (f) Added the wrapper function wvfreadall.m to read all or selected
%     data from a wvf file in a call to the single function wvfreadall.m
% (g) Added sample file "wvf_logicsignals_example.m" explaining access of
%     logic data traces written by the DL7XX scopes.
%
% Version 1.6, 08 December 2009,
% zip-file contents: hdrread.m, wvfread.m, wvfreadb.m, wvfreadall.m,
% wvf__logicsignals_example.m
% (a) Adapted hdrread.m to correctly read files written by newer (verified
%     with model version 6.22) DL750 scopes with muultiple blocks in the
%     "trace" format (some older versions generate as many date entries as
%     blocks exist, the newer models at least sometimes seem to generate
%     only one entry). Thanks to Mathias Graf for reporting this issue.
%
% Version 1.7, 22 March 2011,
%  (a) Removed bug related to optional input parameters datapoints, step
%      and startin. datapoints now is the number of points requested to be
%      returned. Added a warning when requested number
%      is larger than possible due to number of points in the trace.
%      Check ranges of input parameters startind, step, datapoints, and set
%      them to 1 if <1. Added warning if this is done.
%      Thanks to Matthias Hunstig, Univ. Paderborn, for pointing out these
%      issues.
%  (b) Removed bug in wvfread wrapper function regarding varargout
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% beginning of code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warnstate=warning('off'); % to temporarily switch off warning messages
info = hdrread(filename); % read info structure from header file
g_ind=1:info.GroupNumber; % preset reading of all groups (if nargin<2 or if input parameter Group is empty)
if nargin>1
    if ~isempty(Group) %read data from specified groups only
        g_ind=Group(Group>0 & Group<=info.GroupNumber);
    end
end

for groupind=g_ind
    t_ind=1:info.(['Group' num2str(groupind)]).TraceNumber; %preset reading of all traces (if nargin<3 or if input parameter Trace is empty)
    if nargin>2
        if ~isempty(Trace) %read data from specified traces only
            t_ind=Trace(Trace>0 & Trace<=info.(['Group' num2str(groupind)]).TraceNumber);
        end
    end
    b_ind=1:info.(['Group' num2str(groupind)]).BlockNumber; %preset reading of all blocks (if nargin<4 or if input parameter Block is empty)
    if nargin>3
        if ~isempty(Block) %read data from specified blocks only
            b_ind=Block(Block>0 & Block<=info.(['Group' num2str(groupind)]).BlockNumber);
        end
    end
    for traceind=t_ind
        tracename=info.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).TraceName;
        for blockind=b_ind
            [data,t, ind_over, ind_under, ind_illegal] = wvfreadb(filename, groupind, traceind, blockind); % could in principle also add the further optional inputs of wvfreadb.m
            y.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).(['Block' num2str(blockind)])= data;
        end
        y.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).t=t;
        y.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).ind_over=ind_over;
        y.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).ind_under=ind_under;
        y.(['Group' num2str(groupind)]).(['Trace' num2str(traceind)]).ind_illegal=ind_illegal;
    end
end
warning(warnstate)