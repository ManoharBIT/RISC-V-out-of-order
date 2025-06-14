always_comb begin
	// Defaults for all signals
	data0_cam_r3_en = 0;
	data0_cam_r3_index = 0;
	data0_cam_w3_en = 0;
	data0_cam_w3_index = 0;
	data0_cam_w3_data = 0;

	data1_cam_r3_en = 0;
	data1_cam_r3_index = 0;
	data1_cam_w3_en = 0;
	data1_cam_w3_index = 0;
	data1_cam_w3_data = 0;

	data2_cam_r3_en = 0;
	data2_cam_r3_index = 0;
	data2_cam_w3_en = 0;
	data2_cam_w3_index = 0;
	data2_cam_w3_data = 0;

	data3_cam_r3_en = 0;
	data3_cam_r3_index = 0;
	data3_cam_w3_en = 0;
	data3_cam_w3_index = 0;
	data3_cam_w3_data = 0;

	dataN_cam_r3_en = 0;
	dataN_cam_r3_index = 0;
	dataN_cam_w3_en = 0;
	dataN_cam_w3_index = 0;
	dataN_cam_w3_data = 0;

	flush_valid_o = 0;
	flush_entry_o = 0;
	flush = 0;

	for (int i = 0; i < 30; i++) search_valid2[i] = 0;

	case (search_type_o)
		Word2Word, RWord2Half, Half2RWord, Half2Half: begin
			dataN_cam_r3_en = 1;
			dataN_cam_r3_index = store_commit_entry_i;
			dataN_cam_w3_en = 1;
			dataN_cam_w3_index = search_index_o;
			dataN_cam_w3_data = dataN_cam_r3_data;
		end
		LWord2Half: begin
			data2_cam_r3_en = 1;
			data2_cam_r3_index = store_commit_entry_i;
			data3_cam_r3_en = 1;
			data3_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data2_cam_r3_data;
			data1_cam_w3_en = 1;
			data1_cam_w3_index = search_index_o;
			data1_cam_w3_data = data3_cam_r3_data;
		end
		FWord2Byte: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data0_cam_r3_data;
		end
		SWord2Byte: begin
			data1_cam_r3_en = 1;
			data1_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data1_cam_r3_data;
		end
		TWord2Byte: begin
			data2_cam_r3_en = 1;
			data2_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data2_cam_r3_data;
		end
		Half2LWord: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data1_cam_r3_en = 1;
			data1_cam_r3_index = store_commit_entry_i;
			data2_cam_w3_en = 1;
			data2_cam_w3_index = search_index_o;
			data2_cam_w3_data = data0_cam_r3_data;
			data3_cam_w3_en = 1;
			data3_cam_w3_index = search_index_o;
			data3_cam_w3_data = data1_cam_r3_data;
		end
		LHalf2Byte: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data0_cam_r3_data;
		end
		RHalf2Byte: begin
			data1_cam_r3_en = 1;
			data1_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data1_cam_r3_data;
		end
		Byte2FWord: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data3_cam_w3_en = 1;
			data3_cam_w3_index = search_index_o;
			data3_cam_w3_data = data0_cam_r3_data;
		end
		Byte2SWord: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data1_cam_w3_en = 1;
			data1_cam_w3_index = search_index_o;
			data1_cam_w3_data = data0_cam_r3_data;
		end
		Byte2TWord: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data2_cam_w3_en = 1;
			data2_cam_w3_index = search_index_o;
			data2_cam_w3_data = data0_cam_r3_data;
		end
		Byte2RHalf: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data0_cam_r3_data;
		end
		Byte2LHalf: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data1_cam_w3_en = 1;
			data1_cam_w3_index = search_index_o;
			data1_cam_w3_data = data0_cam_r3_data;
		end
		Byte2Byte: begin
			data0_cam_r3_en = 1;
			data0_cam_r3_index = store_commit_entry_i;
			data0_cam_w3_en = 1;
			data0_cam_w3_index = search_index_o;
			data0_cam_w3_data = data0_cam_r3_data;
		end
	endcase

	// SEARCH_VALID2 LOGIC
	for (int iter2 = 0; iter2 < 29; iter2++) begin
		int j;
		if (iter2 + search_valid_o + 1 > 31)
			j = iter2 + search_valid_o + 1 - 32;
		else
			j = iter2 + search_valid_o + 1;

		if (j == tail - 1) break;

		unique case (type_cam_r2_data)
			StoreWord: begin
				if (av_cam_data[j] && type_cam_data[j] inside {LoadWord, LoadHalf, LoadByte}) begin
					if ((type_cam_data[j] == LoadWord && addr_cam_data[j] == addr_cam_r1_data) ||
						(type_cam_data[j] == LoadHalf && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] == addr_cam_r1_data + 16)) ||
						(type_cam_data[j] == LoadByte && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] == addr_cam_r1_data + 8 ||
														  addr_cam_data[j] == addr_cam_r1_data + 16 || addr_cam_data[j] == addr_cam_r1_data + 24)))
						search_valid2[j] = 1;
				end
			end
			StoreHalf: begin
				if (av_cam_data[j] && type_cam_data[j] inside {LoadWord, LoadHalf, LoadByte}) begin
					if ((type_cam_data[j] == LoadWord && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] + 16 == addr_cam_r1_data)) ||
						(type_cam_data[j] == LoadHalf && addr_cam_data[j] == addr_cam_r1_data) ||
						(type_cam_data[j] == LoadByte && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] == addr_cam_r1_data + 8)))
						search_valid2[j] = 1;
				end
			end
			StoreByte: begin
				if (av_cam_data[j] && type_cam_data[j] inside {LoadWord, LoadHalf, LoadByte}) begin
					if ((type_cam_data[j] == LoadWord && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] + 8 == addr_cam_r1_data ||
														  addr_cam_data[j] + 16 == addr_cam_r1_data || addr_cam_data[j] + 24 == addr_cam_r1_data)) ||
						(type_cam_data[j] == LoadHalf && (addr_cam_data[j] == addr_cam_r1_data || addr_cam_data[j] + 8 == addr_cam_r1_data)) ||
						(type_cam_data[j] == LoadByte && addr_cam_data[j] == addr_cam_r1_data))
						search_valid2[j] = 1;
				end
			end
		endcase
	end

	priority casez (search_valid2)
		30'b???????????????????????????????1: flush = search_valid_o + 1;
		30'b??????????????????????????????1?: flush = search_valid_o + 2;
		30'b?????????????????????????????1??: flush = search_valid_o + 3;
		30'b????????????????????????????1???: flush = search_valid_o + 4;
		// Add more lines if you need deeper checking
	endcase

	if (|search_valid2) begin
		flush_valid_o = 1;
		flush_entry_o = (flush > 31) ? flush - 32 : flush;
	end else begin
		flush_valid_o = 0;
		flush_entry_o = 0;
	end
end
