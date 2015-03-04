## = Parameters
## * block_number -- 1 baseed block number to get
## * block_size -- number of frames per a block

function sGramRec_out = getBlock(sGramRec_in, block_number, block_size)
  sGramRec_out = sGramRec_in;
  skip_number = 2;
  end_frame = (block_size + skip_number)*block_number - skip_number;
  start_frame = end_frame - (block_size -1);
  
  sGramRec_out.msec = sGramRec_in.msec(start_frame:end_frame);
  sGramRec_out.msec = sGramRec_out.msec - sGramRec_out.msec(1);
  sGramRec_out.dBm = sGramRec_in.dBm(start_frame:end_frame,:);
endfunction