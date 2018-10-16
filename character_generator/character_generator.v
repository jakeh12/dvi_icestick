module character_generator (
    input pxlclk,
	input [6:0] ascii,
	input [2:0] row,
	output reg [7:0] dout
);

  //
  // wire [7:0] char_line;
  //
  // character_generator cg_0 (
  //   .pxlclk (w_pxlclk),
  //   .ascii  (r_col_cnt[9:3]),
  //   .row    (r_row_cnt[2:0]),
  //   .dout   (char_line)
  // );
  //
  // reg [7:0] char_line_reg;
  // reg [2:0] char_col;
  // reg r_pxl;
  //
  // always @(posedge w_pxlclk) begin
  //   if (r_col_cnt[2:0] == 7) begin
  //     char_line_reg <= char_line;
  //   end
  //   r_pxl <= char_line_reg[char_col];
  //   char_col <= char_col + 1;
  //   if (r_pxl) begin
  //     r_bgr <= 24'hFFFFFF;
  //   end else begin
  //     r_bgr <= 24'h000000;
  //   end
  // end

reg [7:0] char_rom [0:1023];

initial begin
	// 0x00
	char_rom[   0] <= 8'h00; //                 
	char_rom[   1] <= 8'h00; //                 
	char_rom[   2] <= 8'h00; //                 
	char_rom[   3] <= 8'h00; //                 
	char_rom[   4] <= 8'h00; //                 
	char_rom[   5] <= 8'h00; //                 
	char_rom[   6] <= 8'h00; //                 
	char_rom[   7] <= 8'h00; //                 

	// 0x01
	char_rom[   8] <= 8'h00; //                 
	char_rom[   9] <= 8'h00; //                 
	char_rom[  10] <= 8'h00; //                 
	char_rom[  11] <= 8'h00; //                 
	char_rom[  12] <= 8'h00; //                 
	char_rom[  13] <= 8'h00; //                 
	char_rom[  14] <= 8'h00; //                 
	char_rom[  15] <= 8'h00; //                 

	// 0x02
	char_rom[  16] <= 8'h00; //                 
	char_rom[  17] <= 8'h00; //                 
	char_rom[  18] <= 8'h00; //                 
	char_rom[  19] <= 8'h00; //                 
	char_rom[  20] <= 8'h00; //                 
	char_rom[  21] <= 8'h00; //                 
	char_rom[  22] <= 8'h00; //                 
	char_rom[  23] <= 8'h00; //                 

	// 0x03
	char_rom[  24] <= 8'h00; //                 
	char_rom[  25] <= 8'h00; //                 
	char_rom[  26] <= 8'h00; //                 
	char_rom[  27] <= 8'h00; //                 
	char_rom[  28] <= 8'h00; //                 
	char_rom[  29] <= 8'h00; //                 
	char_rom[  30] <= 8'h00; //                 
	char_rom[  31] <= 8'h00; //                 

	// 0x04
	char_rom[  32] <= 8'h00; //                 
	char_rom[  33] <= 8'h00; //                 
	char_rom[  34] <= 8'h00; //                 
	char_rom[  35] <= 8'h00; //                 
	char_rom[  36] <= 8'h00; //                 
	char_rom[  37] <= 8'h00; //                 
	char_rom[  38] <= 8'h00; //                 
	char_rom[  39] <= 8'h00; //                 

	// 0x05
	char_rom[  40] <= 8'h00; //                 
	char_rom[  41] <= 8'h00; //                 
	char_rom[  42] <= 8'h00; //                 
	char_rom[  43] <= 8'h00; //                 
	char_rom[  44] <= 8'h00; //                 
	char_rom[  45] <= 8'h00; //                 
	char_rom[  46] <= 8'h00; //                 
	char_rom[  47] <= 8'h00; //                 

	// 0x06
	char_rom[  48] <= 8'h00; //                 
	char_rom[  49] <= 8'h00; //                 
	char_rom[  50] <= 8'h00; //                 
	char_rom[  51] <= 8'h00; //                 
	char_rom[  52] <= 8'h00; //                 
	char_rom[  53] <= 8'h00; //                 
	char_rom[  54] <= 8'h00; //                 
	char_rom[  55] <= 8'h00; //                 

	// 0x07
	char_rom[  56] <= 8'h00; //                 
	char_rom[  57] <= 8'h00; //                 
	char_rom[  58] <= 8'h00; //                 
	char_rom[  59] <= 8'h00; //                 
	char_rom[  60] <= 8'h00; //                 
	char_rom[  61] <= 8'h00; //                 
	char_rom[  62] <= 8'h00; //                 
	char_rom[  63] <= 8'h00; //                 

	// 0x08
	char_rom[  64] <= 8'h00; //                 
	char_rom[  65] <= 8'h00; //                 
	char_rom[  66] <= 8'h00; //                 
	char_rom[  67] <= 8'h00; //                 
	char_rom[  68] <= 8'h00; //                 
	char_rom[  69] <= 8'h00; //                 
	char_rom[  70] <= 8'h00; //                 
	char_rom[  71] <= 8'h00; //                 

	// 0x09
	char_rom[  72] <= 8'h00; //                 
	char_rom[  73] <= 8'h00; //                 
	char_rom[  74] <= 8'h00; //                 
	char_rom[  75] <= 8'h00; //                 
	char_rom[  76] <= 8'h00; //                 
	char_rom[  77] <= 8'h00; //                 
	char_rom[  78] <= 8'h00; //                 
	char_rom[  79] <= 8'h00; //                 

	// 0x0a
	char_rom[  80] <= 8'h00; //                 
	char_rom[  81] <= 8'h00; //                 
	char_rom[  82] <= 8'h00; //                 
	char_rom[  83] <= 8'h00; //                 
	char_rom[  84] <= 8'h00; //                 
	char_rom[  85] <= 8'h00; //                 
	char_rom[  86] <= 8'h00; //                 
	char_rom[  87] <= 8'h00; //                 

	// 0x0b
	char_rom[  88] <= 8'h00; //                 
	char_rom[  89] <= 8'h00; //                 
	char_rom[  90] <= 8'h00; //                 
	char_rom[  91] <= 8'h00; //                 
	char_rom[  92] <= 8'h00; //                 
	char_rom[  93] <= 8'h00; //                 
	char_rom[  94] <= 8'h00; //                 
	char_rom[  95] <= 8'h00; //                 

	// 0x0c
	char_rom[  96] <= 8'h00; //                 
	char_rom[  97] <= 8'h00; //                 
	char_rom[  98] <= 8'h00; //                 
	char_rom[  99] <= 8'h00; //                 
	char_rom[ 100] <= 8'h00; //                 
	char_rom[ 101] <= 8'h00; //                 
	char_rom[ 102] <= 8'h00; //                 
	char_rom[ 103] <= 8'h00; //                 

	// 0x0d
	char_rom[ 104] <= 8'h00; //                 
	char_rom[ 105] <= 8'h00; //                 
	char_rom[ 106] <= 8'h00; //                 
	char_rom[ 107] <= 8'h00; //                 
	char_rom[ 108] <= 8'h00; //                 
	char_rom[ 109] <= 8'h00; //                 
	char_rom[ 110] <= 8'h00; //                 
	char_rom[ 111] <= 8'h00; //                 

	// 0x0e
	char_rom[ 112] <= 8'h00; //                 
	char_rom[ 113] <= 8'h00; //                 
	char_rom[ 114] <= 8'h00; //                 
	char_rom[ 115] <= 8'h00; //                 
	char_rom[ 116] <= 8'h00; //                 
	char_rom[ 117] <= 8'h00; //                 
	char_rom[ 118] <= 8'h00; //                 
	char_rom[ 119] <= 8'h00; //                 

	// 0x0f
	char_rom[ 120] <= 8'h00; //                 
	char_rom[ 121] <= 8'h00; //                 
	char_rom[ 122] <= 8'h00; //                 
	char_rom[ 123] <= 8'h00; //                 
	char_rom[ 124] <= 8'h00; //                 
	char_rom[ 125] <= 8'h00; //                 
	char_rom[ 126] <= 8'h00; //                 
	char_rom[ 127] <= 8'h00; //                 

	// 0x10
	char_rom[ 128] <= 8'h00; //                 
	char_rom[ 129] <= 8'h00; //                 
	char_rom[ 130] <= 8'h00; //                 
	char_rom[ 131] <= 8'h00; //                 
	char_rom[ 132] <= 8'h00; //                 
	char_rom[ 133] <= 8'h00; //                 
	char_rom[ 134] <= 8'h00; //                 
	char_rom[ 135] <= 8'h00; //                 

	// 0x11
	char_rom[ 136] <= 8'h00; //                 
	char_rom[ 137] <= 8'h00; //                 
	char_rom[ 138] <= 8'h00; //                 
	char_rom[ 139] <= 8'h00; //                 
	char_rom[ 140] <= 8'h00; //                 
	char_rom[ 141] <= 8'h00; //                 
	char_rom[ 142] <= 8'h00; //                 
	char_rom[ 143] <= 8'h00; //                 

	// 0x12
	char_rom[ 144] <= 8'h00; //                 
	char_rom[ 145] <= 8'h00; //                 
	char_rom[ 146] <= 8'h00; //                 
	char_rom[ 147] <= 8'h00; //                 
	char_rom[ 148] <= 8'h00; //                 
	char_rom[ 149] <= 8'h00; //                 
	char_rom[ 150] <= 8'h00; //                 
	char_rom[ 151] <= 8'h00; //                 

	// 0x13
	char_rom[ 152] <= 8'h00; //                 
	char_rom[ 153] <= 8'h00; //                 
	char_rom[ 154] <= 8'h00; //                 
	char_rom[ 155] <= 8'h00; //                 
	char_rom[ 156] <= 8'h00; //                 
	char_rom[ 157] <= 8'h00; //                 
	char_rom[ 158] <= 8'h00; //                 
	char_rom[ 159] <= 8'h00; //                 

	// 0x14
	char_rom[ 160] <= 8'h00; //                 
	char_rom[ 161] <= 8'h00; //                 
	char_rom[ 162] <= 8'h00; //                 
	char_rom[ 163] <= 8'h00; //                 
	char_rom[ 164] <= 8'h00; //                 
	char_rom[ 165] <= 8'h00; //                 
	char_rom[ 166] <= 8'h00; //                 
	char_rom[ 167] <= 8'h00; //                 

	// 0x15
	char_rom[ 168] <= 8'h00; //                 
	char_rom[ 169] <= 8'h00; //                 
	char_rom[ 170] <= 8'h00; //                 
	char_rom[ 171] <= 8'h00; //                 
	char_rom[ 172] <= 8'h00; //                 
	char_rom[ 173] <= 8'h00; //                 
	char_rom[ 174] <= 8'h00; //                 
	char_rom[ 175] <= 8'h00; //                 

	// 0x16
	char_rom[ 176] <= 8'h00; //                 
	char_rom[ 177] <= 8'h00; //                 
	char_rom[ 178] <= 8'h00; //                 
	char_rom[ 179] <= 8'h00; //                 
	char_rom[ 180] <= 8'h00; //                 
	char_rom[ 181] <= 8'h00; //                 
	char_rom[ 182] <= 8'h00; //                 
	char_rom[ 183] <= 8'h00; //                 

	// 0x17
	char_rom[ 184] <= 8'h00; //                 
	char_rom[ 185] <= 8'h00; //                 
	char_rom[ 186] <= 8'h00; //                 
	char_rom[ 187] <= 8'h00; //                 
	char_rom[ 188] <= 8'h00; //                 
	char_rom[ 189] <= 8'h00; //                 
	char_rom[ 190] <= 8'h00; //                 
	char_rom[ 191] <= 8'h00; //                 

	// 0x18
	char_rom[ 192] <= 8'h00; //                 
	char_rom[ 193] <= 8'h00; //                 
	char_rom[ 194] <= 8'h00; //                 
	char_rom[ 195] <= 8'h00; //                 
	char_rom[ 196] <= 8'h00; //                 
	char_rom[ 197] <= 8'h00; //                 
	char_rom[ 198] <= 8'h00; //                 
	char_rom[ 199] <= 8'h00; //                 

	// 0x19
	char_rom[ 200] <= 8'h00; //                 
	char_rom[ 201] <= 8'h00; //                 
	char_rom[ 202] <= 8'h00; //                 
	char_rom[ 203] <= 8'h00; //                 
	char_rom[ 204] <= 8'h00; //                 
	char_rom[ 205] <= 8'h00; //                 
	char_rom[ 206] <= 8'h00; //                 
	char_rom[ 207] <= 8'h00; //                 

	// 0x1a
	char_rom[ 208] <= 8'h00; //                 
	char_rom[ 209] <= 8'h00; //                 
	char_rom[ 210] <= 8'h00; //                 
	char_rom[ 211] <= 8'h00; //                 
	char_rom[ 212] <= 8'h00; //                 
	char_rom[ 213] <= 8'h00; //                 
	char_rom[ 214] <= 8'h00; //                 
	char_rom[ 215] <= 8'h00; //                 

	// 0x1b
	char_rom[ 216] <= 8'h00; //                 
	char_rom[ 217] <= 8'h00; //                 
	char_rom[ 218] <= 8'h00; //                 
	char_rom[ 219] <= 8'h00; //                 
	char_rom[ 220] <= 8'h00; //                 
	char_rom[ 221] <= 8'h00; //                 
	char_rom[ 222] <= 8'h00; //                 
	char_rom[ 223] <= 8'h00; //                 

	// 0x1c
	char_rom[ 224] <= 8'h00; //                 
	char_rom[ 225] <= 8'h00; //                 
	char_rom[ 226] <= 8'h00; //                 
	char_rom[ 227] <= 8'h00; //                 
	char_rom[ 228] <= 8'h00; //                 
	char_rom[ 229] <= 8'h00; //                 
	char_rom[ 230] <= 8'h00; //                 
	char_rom[ 231] <= 8'h00; //                 

	// 0x1d
	char_rom[ 232] <= 8'h00; //                 
	char_rom[ 233] <= 8'h00; //                 
	char_rom[ 234] <= 8'h00; //                 
	char_rom[ 235] <= 8'h00; //                 
	char_rom[ 236] <= 8'h00; //                 
	char_rom[ 237] <= 8'h00; //                 
	char_rom[ 238] <= 8'h00; //                 
	char_rom[ 239] <= 8'h00; //                 

	// 0x1e
	char_rom[ 240] <= 8'h00; //                 
	char_rom[ 241] <= 8'h00; //                 
	char_rom[ 242] <= 8'h00; //                 
	char_rom[ 243] <= 8'h00; //                 
	char_rom[ 244] <= 8'h00; //                 
	char_rom[ 245] <= 8'h00; //                 
	char_rom[ 246] <= 8'h00; //                 
	char_rom[ 247] <= 8'h00; //                 

	// 0x1f
	char_rom[ 248] <= 8'h00; //                 
	char_rom[ 249] <= 8'h00; //                 
	char_rom[ 250] <= 8'h00; //                 
	char_rom[ 251] <= 8'h00; //                 
	char_rom[ 252] <= 8'h00; //                 
	char_rom[ 253] <= 8'h00; //                 
	char_rom[ 254] <= 8'h00; //                 
	char_rom[ 255] <= 8'h00; //                 

	// 0x20 ' '
	char_rom[ 256] <= 8'h00; //                 
	char_rom[ 257] <= 8'h00; //                 
	char_rom[ 258] <= 8'h00; //                 
	char_rom[ 259] <= 8'h00; //                 
	char_rom[ 260] <= 8'h00; //                 
	char_rom[ 261] <= 8'h00; //                 
	char_rom[ 262] <= 8'h00; //                 
	char_rom[ 263] <= 8'h00; //                 

	// 0x21 '!'
	char_rom[ 264] <= 8'h18; //       * *       
	char_rom[ 265] <= 8'h3c; //     * * * *     
	char_rom[ 266] <= 8'h3c; //     * * * *     
	char_rom[ 267] <= 8'h18; //       * *       
	char_rom[ 268] <= 8'h18; //       * *       
	char_rom[ 269] <= 8'h00; //                 
	char_rom[ 270] <= 8'h18; //       * *       
	char_rom[ 271] <= 8'h00; //                 

	// 0x22 '"'
	char_rom[ 272] <= 8'h36; //   * *   * *     
	char_rom[ 273] <= 8'h36; //   * *   * *     
	char_rom[ 274] <= 8'h00; //                 
	char_rom[ 275] <= 8'h00; //                 
	char_rom[ 276] <= 8'h00; //                 
	char_rom[ 277] <= 8'h00; //                 
	char_rom[ 278] <= 8'h00; //                 
	char_rom[ 279] <= 8'h00; //                 

	// 0x23 '#'
	char_rom[ 280] <= 8'h36; //   * *   * *     
	char_rom[ 281] <= 8'h36; //   * *   * *     
	char_rom[ 282] <= 8'h7f; // * * * * * * *   
	char_rom[ 283] <= 8'h36; //   * *   * *     
	char_rom[ 284] <= 8'h7f; // * * * * * * *   
	char_rom[ 285] <= 8'h36; //   * *   * *     
	char_rom[ 286] <= 8'h36; //   * *   * *     
	char_rom[ 287] <= 8'h00; //                 

	// 0x24 '$'
	char_rom[ 288] <= 8'h0c; //     * *         
	char_rom[ 289] <= 8'h3e; //   * * * * *     
	char_rom[ 290] <= 8'h03; // * *             
	char_rom[ 291] <= 8'h1e; //   * * * *       
	char_rom[ 292] <= 8'h30; //         * *     
	char_rom[ 293] <= 8'h1f; // * * * * *       
	char_rom[ 294] <= 8'h0c; //     * *         
	char_rom[ 295] <= 8'h00; //                 

	// 0x25 '%'
	char_rom[ 296] <= 8'h00; //                 
	char_rom[ 297] <= 8'h63; // * *       * *   
	char_rom[ 298] <= 8'h33; // * *     * *     
	char_rom[ 299] <= 8'h18; //       * *       
	char_rom[ 300] <= 8'h0c; //     * *         
	char_rom[ 301] <= 8'h66; //   * *     * *   
	char_rom[ 302] <= 8'h63; // * *       * *   
	char_rom[ 303] <= 8'h00; //                 

	// 0x26 '&'
	char_rom[ 304] <= 8'h1c; //     * * *       
	char_rom[ 305] <= 8'h36; //   * *   * *     
	char_rom[ 306] <= 8'h1c; //     * * *       
	char_rom[ 307] <= 8'h6e; //   * * *   * *   
	char_rom[ 308] <= 8'h3b; // * *   * * *     
	char_rom[ 309] <= 8'h33; // * *     * *     
	char_rom[ 310] <= 8'h6e; //   * * *   * *   
	char_rom[ 311] <= 8'h00; //                 

	// 0x27 '''
	char_rom[ 312] <= 8'h06; //   * *           
	char_rom[ 313] <= 8'h06; //   * *           
	char_rom[ 314] <= 8'h03; // * *             
	char_rom[ 315] <= 8'h00; //                 
	char_rom[ 316] <= 8'h00; //                 
	char_rom[ 317] <= 8'h00; //                 
	char_rom[ 318] <= 8'h00; //                 
	char_rom[ 319] <= 8'h00; //                 

	// 0x28 '('
	char_rom[ 320] <= 8'h18; //       * *       
	char_rom[ 321] <= 8'h0c; //     * *         
	char_rom[ 322] <= 8'h06; //   * *           
	char_rom[ 323] <= 8'h06; //   * *           
	char_rom[ 324] <= 8'h06; //   * *           
	char_rom[ 325] <= 8'h0c; //     * *         
	char_rom[ 326] <= 8'h18; //       * *       
	char_rom[ 327] <= 8'h00; //                 

	// 0x29 ')'
	char_rom[ 328] <= 8'h06; //   * *           
	char_rom[ 329] <= 8'h0c; //     * *         
	char_rom[ 330] <= 8'h18; //       * *       
	char_rom[ 331] <= 8'h18; //       * *       
	char_rom[ 332] <= 8'h18; //       * *       
	char_rom[ 333] <= 8'h0c; //     * *         
	char_rom[ 334] <= 8'h06; //   * *           
	char_rom[ 335] <= 8'h00; //                 

	// 0x2a '*'
	char_rom[ 336] <= 8'h00; //                 
	char_rom[ 337] <= 8'h66; //   * *     * *   
	char_rom[ 338] <= 8'h3c; //     * * * *     
	char_rom[ 339] <= 8'hff; // * * * * * * * * 
	char_rom[ 340] <= 8'h3c; //     * * * *     
	char_rom[ 341] <= 8'h66; //   * *     * *   
	char_rom[ 342] <= 8'h00; //                 
	char_rom[ 343] <= 8'h00; //                 

	// 0x2b '+'
	char_rom[ 344] <= 8'h00; //                 
	char_rom[ 345] <= 8'h0c; //     * *         
	char_rom[ 346] <= 8'h0c; //     * *         
	char_rom[ 347] <= 8'h3f; // * * * * * *     
	char_rom[ 348] <= 8'h0c; //     * *         
	char_rom[ 349] <= 8'h0c; //     * *         
	char_rom[ 350] <= 8'h00; //                 
	char_rom[ 351] <= 8'h00; //                 

	// 0x2c ','
	char_rom[ 352] <= 8'h00; //                 
	char_rom[ 353] <= 8'h00; //                 
	char_rom[ 354] <= 8'h00; //                 
	char_rom[ 355] <= 8'h00; //                 
	char_rom[ 356] <= 8'h00; //                 
	char_rom[ 357] <= 8'h0c; //     * *         
	char_rom[ 358] <= 8'h0c; //     * *         
	char_rom[ 359] <= 8'h06; //   * *           

	// 0x2d '-'
	char_rom[ 360] <= 8'h00; //                 
	char_rom[ 361] <= 8'h00; //                 
	char_rom[ 362] <= 8'h00; //                 
	char_rom[ 363] <= 8'h3f; // * * * * * *     
	char_rom[ 364] <= 8'h00; //                 
	char_rom[ 365] <= 8'h00; //                 
	char_rom[ 366] <= 8'h00; //                 
	char_rom[ 367] <= 8'h00; //                 

	// 0x2e '.'
	char_rom[ 368] <= 8'h00; //                 
	char_rom[ 369] <= 8'h00; //                 
	char_rom[ 370] <= 8'h00; //                 
	char_rom[ 371] <= 8'h00; //                 
	char_rom[ 372] <= 8'h00; //                 
	char_rom[ 373] <= 8'h0c; //     * *         
	char_rom[ 374] <= 8'h0c; //     * *         
	char_rom[ 375] <= 8'h00; //                 

	// 0x2f '/'
	char_rom[ 376] <= 8'h60; //           * *   
	char_rom[ 377] <= 8'h30; //         * *     
	char_rom[ 378] <= 8'h18; //       * *       
	char_rom[ 379] <= 8'h0c; //     * *         
	char_rom[ 380] <= 8'h06; //   * *           
	char_rom[ 381] <= 8'h03; // * *             
	char_rom[ 382] <= 8'h01; // *               
	char_rom[ 383] <= 8'h00; //                 

	// 0x30 '0'
	char_rom[ 384] <= 8'h3e; //   * * * * *     
	char_rom[ 385] <= 8'h63; // * *       * *   
	char_rom[ 386] <= 8'h73; // * *     * * *   
	char_rom[ 387] <= 8'h7b; // * *   * * * *   
	char_rom[ 388] <= 8'h6f; // * * * *   * *   
	char_rom[ 389] <= 8'h67; // * * *     * *   
	char_rom[ 390] <= 8'h3e; //   * * * * *     
	char_rom[ 391] <= 8'h00; //                 

	// 0x31 '1'
	char_rom[ 392] <= 8'h0c; //     * *         
	char_rom[ 393] <= 8'h0e; //   * * *         
	char_rom[ 394] <= 8'h0c; //     * *         
	char_rom[ 395] <= 8'h0c; //     * *         
	char_rom[ 396] <= 8'h0c; //     * *         
	char_rom[ 397] <= 8'h0c; //     * *         
	char_rom[ 398] <= 8'h3f; // * * * * * *     
	char_rom[ 399] <= 8'h00; //                 

	// 0x32 '2'
	char_rom[ 400] <= 8'h1e; //   * * * *       
	char_rom[ 401] <= 8'h33; // * *     * *     
	char_rom[ 402] <= 8'h30; //         * *     
	char_rom[ 403] <= 8'h1c; //     * * *       
	char_rom[ 404] <= 8'h06; //   * *           
	char_rom[ 405] <= 8'h33; // * *     * *     
	char_rom[ 406] <= 8'h3f; // * * * * * *     
	char_rom[ 407] <= 8'h00; //                 

	// 0x33 '3'
	char_rom[ 408] <= 8'h1e; //   * * * *       
	char_rom[ 409] <= 8'h33; // * *     * *     
	char_rom[ 410] <= 8'h30; //         * *     
	char_rom[ 411] <= 8'h1c; //     * * *       
	char_rom[ 412] <= 8'h30; //         * *     
	char_rom[ 413] <= 8'h33; // * *     * *     
	char_rom[ 414] <= 8'h1e; //   * * * *       
	char_rom[ 415] <= 8'h00; //                 

	// 0x34 '4'
	char_rom[ 416] <= 8'h38; //       * * *     
	char_rom[ 417] <= 8'h3c; //     * * * *     
	char_rom[ 418] <= 8'h36; //   * *   * *     
	char_rom[ 419] <= 8'h33; // * *     * *     
	char_rom[ 420] <= 8'h7f; // * * * * * * *   
	char_rom[ 421] <= 8'h30; //         * *     
	char_rom[ 422] <= 8'h78; //       * * * *   
	char_rom[ 423] <= 8'h00; //                 

	// 0x35 '5'
	char_rom[ 424] <= 8'h3f; // * * * * * *     
	char_rom[ 425] <= 8'h03; // * *             
	char_rom[ 426] <= 8'h1f; // * * * * *       
	char_rom[ 427] <= 8'h30; //         * *     
	char_rom[ 428] <= 8'h30; //         * *     
	char_rom[ 429] <= 8'h33; // * *     * *     
	char_rom[ 430] <= 8'h1e; //   * * * *       
	char_rom[ 431] <= 8'h00; //                 

	// 0x36 '6'
	char_rom[ 432] <= 8'h1c; //     * * *       
	char_rom[ 433] <= 8'h06; //   * *           
	char_rom[ 434] <= 8'h03; // * *             
	char_rom[ 435] <= 8'h1f; // * * * * *       
	char_rom[ 436] <= 8'h33; // * *     * *     
	char_rom[ 437] <= 8'h33; // * *     * *     
	char_rom[ 438] <= 8'h1e; //   * * * *       
	char_rom[ 439] <= 8'h00; //                 

	// 0x37 '7'
	char_rom[ 440] <= 8'h3f; // * * * * * *     
	char_rom[ 441] <= 8'h33; // * *     * *     
	char_rom[ 442] <= 8'h30; //         * *     
	char_rom[ 443] <= 8'h18; //       * *       
	char_rom[ 444] <= 8'h0c; //     * *         
	char_rom[ 445] <= 8'h0c; //     * *         
	char_rom[ 446] <= 8'h0c; //     * *         
	char_rom[ 447] <= 8'h00; //                 

	// 0x38 '8'
	char_rom[ 448] <= 8'h1e; //   * * * *       
	char_rom[ 449] <= 8'h33; // * *     * *     
	char_rom[ 450] <= 8'h33; // * *     * *     
	char_rom[ 451] <= 8'h1e; //   * * * *       
	char_rom[ 452] <= 8'h33; // * *     * *     
	char_rom[ 453] <= 8'h33; // * *     * *     
	char_rom[ 454] <= 8'h1e; //   * * * *       
	char_rom[ 455] <= 8'h00; //                 

	// 0x39 '9'
	char_rom[ 456] <= 8'h1e; //   * * * *       
	char_rom[ 457] <= 8'h33; // * *     * *     
	char_rom[ 458] <= 8'h33; // * *     * *     
	char_rom[ 459] <= 8'h3e; //   * * * * *     
	char_rom[ 460] <= 8'h30; //         * *     
	char_rom[ 461] <= 8'h18; //       * *       
	char_rom[ 462] <= 8'h0e; //   * * *         
	char_rom[ 463] <= 8'h00; //                 

	// 0x3a ':'
	char_rom[ 464] <= 8'h00; //                 
	char_rom[ 465] <= 8'h0c; //     * *         
	char_rom[ 466] <= 8'h0c; //     * *         
	char_rom[ 467] <= 8'h00; //                 
	char_rom[ 468] <= 8'h00; //                 
	char_rom[ 469] <= 8'h0c; //     * *         
	char_rom[ 470] <= 8'h0c; //     * *         
	char_rom[ 471] <= 8'h00; //                 

	// 0x3b ';'
	char_rom[ 472] <= 8'h00; //                 
	char_rom[ 473] <= 8'h0c; //     * *         
	char_rom[ 474] <= 8'h0c; //     * *         
	char_rom[ 475] <= 8'h00; //                 
	char_rom[ 476] <= 8'h00; //                 
	char_rom[ 477] <= 8'h0c; //     * *         
	char_rom[ 478] <= 8'h0c; //     * *         
	char_rom[ 479] <= 8'h06; //   * *           

	// 0x3c '<'
	char_rom[ 480] <= 8'h18; //       * *       
	char_rom[ 481] <= 8'h0c; //     * *         
	char_rom[ 482] <= 8'h06; //   * *           
	char_rom[ 483] <= 8'h03; // * *             
	char_rom[ 484] <= 8'h06; //   * *           
	char_rom[ 485] <= 8'h0c; //     * *         
	char_rom[ 486] <= 8'h18; //       * *       
	char_rom[ 487] <= 8'h00; //                 

	// 0x3d '='
	char_rom[ 488] <= 8'h00; //                 
	char_rom[ 489] <= 8'h00; //                 
	char_rom[ 490] <= 8'h3f; // * * * * * *     
	char_rom[ 491] <= 8'h00; //                 
	char_rom[ 492] <= 8'h00; //                 
	char_rom[ 493] <= 8'h3f; // * * * * * *     
	char_rom[ 494] <= 8'h00; //                 
	char_rom[ 495] <= 8'h00; //                 

	// 0x3e '>'
	char_rom[ 496] <= 8'h06; //   * *           
	char_rom[ 497] <= 8'h0c; //     * *         
	char_rom[ 498] <= 8'h18; //       * *       
	char_rom[ 499] <= 8'h30; //         * *     
	char_rom[ 500] <= 8'h18; //       * *       
	char_rom[ 501] <= 8'h0c; //     * *         
	char_rom[ 502] <= 8'h06; //   * *           
	char_rom[ 503] <= 8'h00; //                 

	// 0x3f '?'
	char_rom[ 504] <= 8'h1e; //   * * * *       
	char_rom[ 505] <= 8'h33; // * *     * *     
	char_rom[ 506] <= 8'h30; //         * *     
	char_rom[ 507] <= 8'h18; //       * *       
	char_rom[ 508] <= 8'h0c; //     * *         
	char_rom[ 509] <= 8'h00; //                 
	char_rom[ 510] <= 8'h0c; //     * *         
	char_rom[ 511] <= 8'h00; //                 

	// 0x40 '@'
	char_rom[ 512] <= 8'h3e; //   * * * * *     
	char_rom[ 513] <= 8'h63; // * *       * *   
	char_rom[ 514] <= 8'h7b; // * *   * * * *   
	char_rom[ 515] <= 8'h7b; // * *   * * * *   
	char_rom[ 516] <= 8'h7b; // * *   * * * *   
	char_rom[ 517] <= 8'h03; // * *             
	char_rom[ 518] <= 8'h1e; //   * * * *       
	char_rom[ 519] <= 8'h00; //                 

	// 0x41 'A'
	char_rom[ 520] <= 8'h0c; //     * *         
	char_rom[ 521] <= 8'h1e; //   * * * *       
	char_rom[ 522] <= 8'h33; // * *     * *     
	char_rom[ 523] <= 8'h33; // * *     * *     
	char_rom[ 524] <= 8'h3f; // * * * * * *     
	char_rom[ 525] <= 8'h33; // * *     * *     
	char_rom[ 526] <= 8'h33; // * *     * *     
	char_rom[ 527] <= 8'h00; //                 

	// 0x42 'B'
	char_rom[ 528] <= 8'h3f; // * * * * * *     
	char_rom[ 529] <= 8'h66; //   * *     * *   
	char_rom[ 530] <= 8'h66; //   * *     * *   
	char_rom[ 531] <= 8'h3e; //   * * * * *     
	char_rom[ 532] <= 8'h66; //   * *     * *   
	char_rom[ 533] <= 8'h66; //   * *     * *   
	char_rom[ 534] <= 8'h3f; // * * * * * *     
	char_rom[ 535] <= 8'h00; //                 

	// 0x43 'C'
	char_rom[ 536] <= 8'h3c; //     * * * *     
	char_rom[ 537] <= 8'h66; //   * *     * *   
	char_rom[ 538] <= 8'h03; // * *             
	char_rom[ 539] <= 8'h03; // * *             
	char_rom[ 540] <= 8'h03; // * *             
	char_rom[ 541] <= 8'h66; //   * *     * *   
	char_rom[ 542] <= 8'h3c; //     * * * *     
	char_rom[ 543] <= 8'h00; //                 

	// 0x44 'D'
	char_rom[ 544] <= 8'h1f; // * * * * *       
	char_rom[ 545] <= 8'h36; //   * *   * *     
	char_rom[ 546] <= 8'h66; //   * *     * *   
	char_rom[ 547] <= 8'h66; //   * *     * *   
	char_rom[ 548] <= 8'h66; //   * *     * *   
	char_rom[ 549] <= 8'h36; //   * *   * *     
	char_rom[ 550] <= 8'h1f; // * * * * *       
	char_rom[ 551] <= 8'h00; //                 

	// 0x45 'E'
	char_rom[ 552] <= 8'h7f; // * * * * * * *   
	char_rom[ 553] <= 8'h46; //   * *       *   
	char_rom[ 554] <= 8'h16; //   * *   *       
	char_rom[ 555] <= 8'h1e; //   * * * *       
	char_rom[ 556] <= 8'h16; //   * *   *       
	char_rom[ 557] <= 8'h46; //   * *       *   
	char_rom[ 558] <= 8'h7f; // * * * * * * *   
	char_rom[ 559] <= 8'h00; //                 

	// 0x46 'F'
	char_rom[ 560] <= 8'h7f; // * * * * * * *   
	char_rom[ 561] <= 8'h46; //   * *       *   
	char_rom[ 562] <= 8'h16; //   * *   *       
	char_rom[ 563] <= 8'h1e; //   * * * *       
	char_rom[ 564] <= 8'h16; //   * *   *       
	char_rom[ 565] <= 8'h06; //   * *           
	char_rom[ 566] <= 8'h0f; // * * * *         
	char_rom[ 567] <= 8'h00; //                 

	// 0x47 'G'
	char_rom[ 568] <= 8'h3c; //     * * * *     
	char_rom[ 569] <= 8'h66; //   * *     * *   
	char_rom[ 570] <= 8'h03; // * *             
	char_rom[ 571] <= 8'h03; // * *             
	char_rom[ 572] <= 8'h73; // * *     * * *   
	char_rom[ 573] <= 8'h66; //   * *     * *   
	char_rom[ 574] <= 8'h7c; //     * * * * *   
	char_rom[ 575] <= 8'h00; //                 

	// 0x48 'H'
	char_rom[ 576] <= 8'h33; // * *     * *     
	char_rom[ 577] <= 8'h33; // * *     * *     
	char_rom[ 578] <= 8'h33; // * *     * *     
	char_rom[ 579] <= 8'h3f; // * * * * * *     
	char_rom[ 580] <= 8'h33; // * *     * *     
	char_rom[ 581] <= 8'h33; // * *     * *     
	char_rom[ 582] <= 8'h33; // * *     * *     
	char_rom[ 583] <= 8'h00; //                 

	// 0x49 'I'
	char_rom[ 584] <= 8'h1e; //   * * * *       
	char_rom[ 585] <= 8'h0c; //     * *         
	char_rom[ 586] <= 8'h0c; //     * *         
	char_rom[ 587] <= 8'h0c; //     * *         
	char_rom[ 588] <= 8'h0c; //     * *         
	char_rom[ 589] <= 8'h0c; //     * *         
	char_rom[ 590] <= 8'h1e; //   * * * *       
	char_rom[ 591] <= 8'h00; //                 

	// 0x4a 'J'
	char_rom[ 592] <= 8'h78; //       * * * *   
	char_rom[ 593] <= 8'h30; //         * *     
	char_rom[ 594] <= 8'h30; //         * *     
	char_rom[ 595] <= 8'h30; //         * *     
	char_rom[ 596] <= 8'h33; // * *     * *     
	char_rom[ 597] <= 8'h33; // * *     * *     
	char_rom[ 598] <= 8'h1e; //   * * * *       
	char_rom[ 599] <= 8'h00; //                 

	// 0x4b 'K'
	char_rom[ 600] <= 8'h67; // * * *     * *   
	char_rom[ 601] <= 8'h66; //   * *     * *   
	char_rom[ 602] <= 8'h36; //   * *   * *     
	char_rom[ 603] <= 8'h1e; //   * * * *       
	char_rom[ 604] <= 8'h36; //   * *   * *     
	char_rom[ 605] <= 8'h66; //   * *     * *   
	char_rom[ 606] <= 8'h67; // * * *     * *   
	char_rom[ 607] <= 8'h00; //                 

	// 0x4c 'L'
	char_rom[ 608] <= 8'h0f; // * * * *         
	char_rom[ 609] <= 8'h06; //   * *           
	char_rom[ 610] <= 8'h06; //   * *           
	char_rom[ 611] <= 8'h06; //   * *           
	char_rom[ 612] <= 8'h46; //   * *       *   
	char_rom[ 613] <= 8'h66; //   * *     * *   
	char_rom[ 614] <= 8'h7f; // * * * * * * *   
	char_rom[ 615] <= 8'h00; //                 

	// 0x4d 'M'
	char_rom[ 616] <= 8'h63; // * *       * *   
	char_rom[ 617] <= 8'h77; // * * *   * * *   
	char_rom[ 618] <= 8'h7f; // * * * * * * *   
	char_rom[ 619] <= 8'h7f; // * * * * * * *   
	char_rom[ 620] <= 8'h6b; // * *   *   * *   
	char_rom[ 621] <= 8'h63; // * *       * *   
	char_rom[ 622] <= 8'h63; // * *       * *   
	char_rom[ 623] <= 8'h00; //                 

	// 0x4e 'N'
	char_rom[ 624] <= 8'h63; // * *       * *   
	char_rom[ 625] <= 8'h67; // * * *     * *   
	char_rom[ 626] <= 8'h6f; // * * * *   * *   
	char_rom[ 627] <= 8'h7b; // * *   * * * *   
	char_rom[ 628] <= 8'h73; // * *     * * *   
	char_rom[ 629] <= 8'h63; // * *       * *   
	char_rom[ 630] <= 8'h63; // * *       * *   
	char_rom[ 631] <= 8'h00; //                 

	// 0x4f 'O'
	char_rom[ 632] <= 8'h1c; //     * * *       
	char_rom[ 633] <= 8'h36; //   * *   * *     
	char_rom[ 634] <= 8'h63; // * *       * *   
	char_rom[ 635] <= 8'h63; // * *       * *   
	char_rom[ 636] <= 8'h63; // * *       * *   
	char_rom[ 637] <= 8'h36; //   * *   * *     
	char_rom[ 638] <= 8'h1c; //     * * *       
	char_rom[ 639] <= 8'h00; //                 

	// 0x50 'P'
	char_rom[ 640] <= 8'h3f; // * * * * * *     
	char_rom[ 641] <= 8'h66; //   * *     * *   
	char_rom[ 642] <= 8'h66; //   * *     * *   
	char_rom[ 643] <= 8'h3e; //   * * * * *     
	char_rom[ 644] <= 8'h06; //   * *           
	char_rom[ 645] <= 8'h06; //   * *           
	char_rom[ 646] <= 8'h0f; // * * * *         
	char_rom[ 647] <= 8'h00; //                 

	// 0x51 'Q'
	char_rom[ 648] <= 8'h1e; //   * * * *       
	char_rom[ 649] <= 8'h33; // * *     * *     
	char_rom[ 650] <= 8'h33; // * *     * *     
	char_rom[ 651] <= 8'h33; // * *     * *     
	char_rom[ 652] <= 8'h3b; // * *   * * *     
	char_rom[ 653] <= 8'h1e; //   * * * *       
	char_rom[ 654] <= 8'h38; //       * * *     
	char_rom[ 655] <= 8'h00; //                 

	// 0x52 'R'
	char_rom[ 656] <= 8'h3f; // * * * * * *     
	char_rom[ 657] <= 8'h66; //   * *     * *   
	char_rom[ 658] <= 8'h66; //   * *     * *   
	char_rom[ 659] <= 8'h3e; //   * * * * *     
	char_rom[ 660] <= 8'h36; //   * *   * *     
	char_rom[ 661] <= 8'h66; //   * *     * *   
	char_rom[ 662] <= 8'h67; // * * *     * *   
	char_rom[ 663] <= 8'h00; //                 

	// 0x53 'S'
	char_rom[ 664] <= 8'h1e; //   * * * *       
	char_rom[ 665] <= 8'h33; // * *     * *     
	char_rom[ 666] <= 8'h07; // * * *           
	char_rom[ 667] <= 8'h0e; //   * * *         
	char_rom[ 668] <= 8'h38; //       * * *     
	char_rom[ 669] <= 8'h33; // * *     * *     
	char_rom[ 670] <= 8'h1e; //   * * * *       
	char_rom[ 671] <= 8'h00; //                 

	// 0x54 'T'
	char_rom[ 672] <= 8'h3f; // * * * * * *     
	char_rom[ 673] <= 8'h2d; // *   * *   *     
	char_rom[ 674] <= 8'h0c; //     * *         
	char_rom[ 675] <= 8'h0c; //     * *         
	char_rom[ 676] <= 8'h0c; //     * *         
	char_rom[ 677] <= 8'h0c; //     * *         
	char_rom[ 678] <= 8'h1e; //   * * * *       
	char_rom[ 679] <= 8'h00; //                 

	// 0x55 'U'
	char_rom[ 680] <= 8'h33; // * *     * *     
	char_rom[ 681] <= 8'h33; // * *     * *     
	char_rom[ 682] <= 8'h33; // * *     * *     
	char_rom[ 683] <= 8'h33; // * *     * *     
	char_rom[ 684] <= 8'h33; // * *     * *     
	char_rom[ 685] <= 8'h33; // * *     * *     
	char_rom[ 686] <= 8'h3f; // * * * * * *     
	char_rom[ 687] <= 8'h00; //                 

	// 0x56 'V'
	char_rom[ 688] <= 8'h33; // * *     * *     
	char_rom[ 689] <= 8'h33; // * *     * *     
	char_rom[ 690] <= 8'h33; // * *     * *     
	char_rom[ 691] <= 8'h33; // * *     * *     
	char_rom[ 692] <= 8'h33; // * *     * *     
	char_rom[ 693] <= 8'h1e; //   * * * *       
	char_rom[ 694] <= 8'h0c; //     * *         
	char_rom[ 695] <= 8'h00; //                 

	// 0x57 'W'
	char_rom[ 696] <= 8'h63; // * *       * *   
	char_rom[ 697] <= 8'h63; // * *       * *   
	char_rom[ 698] <= 8'h63; // * *       * *   
	char_rom[ 699] <= 8'h6b; // * *   *   * *   
	char_rom[ 700] <= 8'h7f; // * * * * * * *   
	char_rom[ 701] <= 8'h77; // * * *   * * *   
	char_rom[ 702] <= 8'h63; // * *       * *   
	char_rom[ 703] <= 8'h00; //                 

	// 0x58 'X'
	char_rom[ 704] <= 8'h63; // * *       * *   
	char_rom[ 705] <= 8'h63; // * *       * *   
	char_rom[ 706] <= 8'h36; //   * *   * *     
	char_rom[ 707] <= 8'h1c; //     * * *       
	char_rom[ 708] <= 8'h1c; //     * * *       
	char_rom[ 709] <= 8'h36; //   * *   * *     
	char_rom[ 710] <= 8'h63; // * *       * *   
	char_rom[ 711] <= 8'h00; //                 

	// 0x59 'Y'
	char_rom[ 712] <= 8'h33; // * *     * *     
	char_rom[ 713] <= 8'h33; // * *     * *     
	char_rom[ 714] <= 8'h33; // * *     * *     
	char_rom[ 715] <= 8'h1e; //   * * * *       
	char_rom[ 716] <= 8'h0c; //     * *         
	char_rom[ 717] <= 8'h0c; //     * *         
	char_rom[ 718] <= 8'h1e; //   * * * *       
	char_rom[ 719] <= 8'h00; //                 

	// 0x5a 'Z'
	char_rom[ 720] <= 8'h7f; // * * * * * * *   
	char_rom[ 721] <= 8'h63; // * *       * *   
	char_rom[ 722] <= 8'h31; // *       * *     
	char_rom[ 723] <= 8'h18; //       * *       
	char_rom[ 724] <= 8'h4c; //     * *     *   
	char_rom[ 725] <= 8'h66; //   * *     * *   
	char_rom[ 726] <= 8'h7f; // * * * * * * *   
	char_rom[ 727] <= 8'h00; //                 

	// 0x5b '['
	char_rom[ 728] <= 8'h1e; //   * * * *       
	char_rom[ 729] <= 8'h06; //   * *           
	char_rom[ 730] <= 8'h06; //   * *           
	char_rom[ 731] <= 8'h06; //   * *           
	char_rom[ 732] <= 8'h06; //   * *           
	char_rom[ 733] <= 8'h06; //   * *           
	char_rom[ 734] <= 8'h1e; //   * * * *       
	char_rom[ 735] <= 8'h00; //                 

	// 0x5c '\'
	char_rom[ 736] <= 8'h03; // * *             
	char_rom[ 737] <= 8'h06; //   * *           
	char_rom[ 738] <= 8'h0c; //     * *         
	char_rom[ 739] <= 8'h18; //       * *       
	char_rom[ 740] <= 8'h30; //         * *     
	char_rom[ 741] <= 8'h60; //           * *   
	char_rom[ 742] <= 8'h40; //             *   
	char_rom[ 743] <= 8'h00; //                 

	// 0x5d ']'
	char_rom[ 744] <= 8'h1e; //   * * * *       
	char_rom[ 745] <= 8'h18; //       * *       
	char_rom[ 746] <= 8'h18; //       * *       
	char_rom[ 747] <= 8'h18; //       * *       
	char_rom[ 748] <= 8'h18; //       * *       
	char_rom[ 749] <= 8'h18; //       * *       
	char_rom[ 750] <= 8'h1e; //   * * * *       
	char_rom[ 751] <= 8'h00; //                 

	// 0x5e '^'
	char_rom[ 752] <= 8'h08; //       *         
	char_rom[ 753] <= 8'h1c; //     * * *       
	char_rom[ 754] <= 8'h36; //   * *   * *     
	char_rom[ 755] <= 8'h63; // * *       * *   
	char_rom[ 756] <= 8'h00; //                 
	char_rom[ 757] <= 8'h00; //                 
	char_rom[ 758] <= 8'h00; //                 
	char_rom[ 759] <= 8'h00; //                 

	// 0x5f '_'
	char_rom[ 760] <= 8'h00; //                 
	char_rom[ 761] <= 8'h00; //                 
	char_rom[ 762] <= 8'h00; //                 
	char_rom[ 763] <= 8'h00; //                 
	char_rom[ 764] <= 8'h00; //                 
	char_rom[ 765] <= 8'h00; //                 
	char_rom[ 766] <= 8'h00; //                 
	char_rom[ 767] <= 8'hff; // * * * * * * * * 

	// 0x60 '`'
	char_rom[ 768] <= 8'h0c; //     * *         
	char_rom[ 769] <= 8'h0c; //     * *         
	char_rom[ 770] <= 8'h18; //       * *       
	char_rom[ 771] <= 8'h00; //                 
	char_rom[ 772] <= 8'h00; //                 
	char_rom[ 773] <= 8'h00; //                 
	char_rom[ 774] <= 8'h00; //                 
	char_rom[ 775] <= 8'h00; //                 

	// 0x61 'a'
	char_rom[ 776] <= 8'h00; //                 
	char_rom[ 777] <= 8'h00; //                 
	char_rom[ 778] <= 8'h1e; //   * * * *       
	char_rom[ 779] <= 8'h30; //         * *     
	char_rom[ 780] <= 8'h3e; //   * * * * *     
	char_rom[ 781] <= 8'h33; // * *     * *     
	char_rom[ 782] <= 8'h6e; //   * * *   * *   
	char_rom[ 783] <= 8'h00; //                 

	// 0x62 'b'
	char_rom[ 784] <= 8'h07; // * * *           
	char_rom[ 785] <= 8'h06; //   * *           
	char_rom[ 786] <= 8'h06; //   * *           
	char_rom[ 787] <= 8'h3e; //   * * * * *     
	char_rom[ 788] <= 8'h66; //   * *     * *   
	char_rom[ 789] <= 8'h66; //   * *     * *   
	char_rom[ 790] <= 8'h3b; // * *   * * *     
	char_rom[ 791] <= 8'h00; //                 

	// 0x63 'c'
	char_rom[ 792] <= 8'h00; //                 
	char_rom[ 793] <= 8'h00; //                 
	char_rom[ 794] <= 8'h1e; //   * * * *       
	char_rom[ 795] <= 8'h33; // * *     * *     
	char_rom[ 796] <= 8'h03; // * *             
	char_rom[ 797] <= 8'h33; // * *     * *     
	char_rom[ 798] <= 8'h1e; //   * * * *       
	char_rom[ 799] <= 8'h00; //                 

	// 0x64 'd'
	char_rom[ 800] <= 8'h38; //       * * *     
	char_rom[ 801] <= 8'h30; //         * *     
	char_rom[ 802] <= 8'h30; //         * *     
	char_rom[ 803] <= 8'h3e; //   * * * * *     
	char_rom[ 804] <= 8'h33; // * *     * *     
	char_rom[ 805] <= 8'h33; // * *     * *     
	char_rom[ 806] <= 8'h6e; //   * * *   * *   
	char_rom[ 807] <= 8'h00; //                 

	// 0x65 'e'
	char_rom[ 808] <= 8'h00; //                 
	char_rom[ 809] <= 8'h00; //                 
	char_rom[ 810] <= 8'h1e; //   * * * *       
	char_rom[ 811] <= 8'h33; // * *     * *     
	char_rom[ 812] <= 8'h3f; // * * * * * *     
	char_rom[ 813] <= 8'h03; // * *             
	char_rom[ 814] <= 8'h1e; //   * * * *       
	char_rom[ 815] <= 8'h00; //                 

	// 0x66 'f'
	char_rom[ 816] <= 8'h1c; //     * * *       
	char_rom[ 817] <= 8'h36; //   * *   * *     
	char_rom[ 818] <= 8'h06; //   * *           
	char_rom[ 819] <= 8'h0f; // * * * *         
	char_rom[ 820] <= 8'h06; //   * *           
	char_rom[ 821] <= 8'h06; //   * *           
	char_rom[ 822] <= 8'h0f; // * * * *         
	char_rom[ 823] <= 8'h00; //                 

	// 0x67 'g'
	char_rom[ 824] <= 8'h00; //                 
	char_rom[ 825] <= 8'h00; //                 
	char_rom[ 826] <= 8'h6e; //   * * *   * *   
	char_rom[ 827] <= 8'h33; // * *     * *     
	char_rom[ 828] <= 8'h33; // * *     * *     
	char_rom[ 829] <= 8'h3e; //   * * * * *     
	char_rom[ 830] <= 8'h30; //         * *     
	char_rom[ 831] <= 8'h1f; // * * * * *       

	// 0x68 'h'
	char_rom[ 832] <= 8'h07; // * * *           
	char_rom[ 833] <= 8'h06; //   * *           
	char_rom[ 834] <= 8'h36; //   * *   * *     
	char_rom[ 835] <= 8'h6e; //   * * *   * *   
	char_rom[ 836] <= 8'h66; //   * *     * *   
	char_rom[ 837] <= 8'h66; //   * *     * *   
	char_rom[ 838] <= 8'h67; // * * *     * *   
	char_rom[ 839] <= 8'h00; //                 

	// 0x69 'i'
	char_rom[ 840] <= 8'h0c; //     * *         
	char_rom[ 841] <= 8'h00; //                 
	char_rom[ 842] <= 8'h0e; //   * * *         
	char_rom[ 843] <= 8'h0c; //     * *         
	char_rom[ 844] <= 8'h0c; //     * *         
	char_rom[ 845] <= 8'h0c; //     * *         
	char_rom[ 846] <= 8'h1e; //   * * * *       
	char_rom[ 847] <= 8'h00; //                 

	// 0x6a 'j'
	char_rom[ 848] <= 8'h30; //         * *     
	char_rom[ 849] <= 8'h00; //                 
	char_rom[ 850] <= 8'h30; //         * *     
	char_rom[ 851] <= 8'h30; //         * *     
	char_rom[ 852] <= 8'h30; //         * *     
	char_rom[ 853] <= 8'h33; // * *     * *     
	char_rom[ 854] <= 8'h33; // * *     * *     
	char_rom[ 855] <= 8'h1e; //   * * * *       

	// 0x6b 'k'
	char_rom[ 856] <= 8'h07; // * * *           
	char_rom[ 857] <= 8'h06; //   * *           
	char_rom[ 858] <= 8'h66; //   * *     * *   
	char_rom[ 859] <= 8'h36; //   * *   * *     
	char_rom[ 860] <= 8'h1e; //   * * * *       
	char_rom[ 861] <= 8'h36; //   * *   * *     
	char_rom[ 862] <= 8'h67; // * * *     * *   
	char_rom[ 863] <= 8'h00; //                 

	// 0x6c 'l'
	char_rom[ 864] <= 8'h0e; //   * * *         
	char_rom[ 865] <= 8'h0c; //     * *         
	char_rom[ 866] <= 8'h0c; //     * *         
	char_rom[ 867] <= 8'h0c; //     * *         
	char_rom[ 868] <= 8'h0c; //     * *         
	char_rom[ 869] <= 8'h0c; //     * *         
	char_rom[ 870] <= 8'h1e; //   * * * *       
	char_rom[ 871] <= 8'h00; //                 

	// 0x6d 'm'
	char_rom[ 872] <= 8'h00; //                 
	char_rom[ 873] <= 8'h00; //                 
	char_rom[ 874] <= 8'h33; // * *     * *     
	char_rom[ 875] <= 8'h7f; // * * * * * * *   
	char_rom[ 876] <= 8'h7f; // * * * * * * *   
	char_rom[ 877] <= 8'h6b; // * *   *   * *   
	char_rom[ 878] <= 8'h63; // * *       * *   
	char_rom[ 879] <= 8'h00; //                 

	// 0x6e 'n'
	char_rom[ 880] <= 8'h00; //                 
	char_rom[ 881] <= 8'h00; //                 
	char_rom[ 882] <= 8'h1f; // * * * * *       
	char_rom[ 883] <= 8'h33; // * *     * *     
	char_rom[ 884] <= 8'h33; // * *     * *     
	char_rom[ 885] <= 8'h33; // * *     * *     
	char_rom[ 886] <= 8'h33; // * *     * *     
	char_rom[ 887] <= 8'h00; //                 

	// 0x6f 'o'
	char_rom[ 888] <= 8'h00; //                 
	char_rom[ 889] <= 8'h00; //                 
	char_rom[ 890] <= 8'h1e; //   * * * *       
	char_rom[ 891] <= 8'h33; // * *     * *     
	char_rom[ 892] <= 8'h33; // * *     * *     
	char_rom[ 893] <= 8'h33; // * *     * *     
	char_rom[ 894] <= 8'h1e; //   * * * *       
	char_rom[ 895] <= 8'h00; //                 

	// 0x70 'p'
	char_rom[ 896] <= 8'h00; //                 
	char_rom[ 897] <= 8'h00; //                 
	char_rom[ 898] <= 8'h3b; // * *   * * *     
	char_rom[ 899] <= 8'h66; //   * *     * *   
	char_rom[ 900] <= 8'h66; //   * *     * *   
	char_rom[ 901] <= 8'h3e; //   * * * * *     
	char_rom[ 902] <= 8'h06; //   * *           
	char_rom[ 903] <= 8'h0f; // * * * *         

	// 0x71 'q'
	char_rom[ 904] <= 8'h00; //                 
	char_rom[ 905] <= 8'h00; //                 
	char_rom[ 906] <= 8'h6e; //   * * *   * *   
	char_rom[ 907] <= 8'h33; // * *     * *     
	char_rom[ 908] <= 8'h33; // * *     * *     
	char_rom[ 909] <= 8'h3e; //   * * * * *     
	char_rom[ 910] <= 8'h30; //         * *     
	char_rom[ 911] <= 8'h78; //       * * * *   

	// 0x72 'r'
	char_rom[ 912] <= 8'h00; //                 
	char_rom[ 913] <= 8'h00; //                 
	char_rom[ 914] <= 8'h3b; // * *   * * *     
	char_rom[ 915] <= 8'h6e; //   * * *   * *   
	char_rom[ 916] <= 8'h66; //   * *     * *   
	char_rom[ 917] <= 8'h06; //   * *           
	char_rom[ 918] <= 8'h0f; // * * * *         
	char_rom[ 919] <= 8'h00; //                 

	// 0x73 's'
	char_rom[ 920] <= 8'h00; //                 
	char_rom[ 921] <= 8'h00; //                 
	char_rom[ 922] <= 8'h3e; //   * * * * *     
	char_rom[ 923] <= 8'h03; // * *             
	char_rom[ 924] <= 8'h1e; //   * * * *       
	char_rom[ 925] <= 8'h30; //         * *     
	char_rom[ 926] <= 8'h1f; // * * * * *       
	char_rom[ 927] <= 8'h00; //                 

	// 0x74 't'
	char_rom[ 928] <= 8'h08; //       *         
	char_rom[ 929] <= 8'h0c; //     * *         
	char_rom[ 930] <= 8'h3e; //   * * * * *     
	char_rom[ 931] <= 8'h0c; //     * *         
	char_rom[ 932] <= 8'h0c; //     * *         
	char_rom[ 933] <= 8'h2c; //     * *   *     
	char_rom[ 934] <= 8'h18; //       * *       
	char_rom[ 935] <= 8'h00; //                 

	// 0x75 'u'
	char_rom[ 936] <= 8'h00; //                 
	char_rom[ 937] <= 8'h00; //                 
	char_rom[ 938] <= 8'h33; // * *     * *     
	char_rom[ 939] <= 8'h33; // * *     * *     
	char_rom[ 940] <= 8'h33; // * *     * *     
	char_rom[ 941] <= 8'h33; // * *     * *     
	char_rom[ 942] <= 8'h6e; //   * * *   * *   
	char_rom[ 943] <= 8'h00; //                 

	// 0x76 'v'
	char_rom[ 944] <= 8'h00; //                 
	char_rom[ 945] <= 8'h00; //                 
	char_rom[ 946] <= 8'h33; // * *     * *     
	char_rom[ 947] <= 8'h33; // * *     * *     
	char_rom[ 948] <= 8'h33; // * *     * *     
	char_rom[ 949] <= 8'h1e; //   * * * *       
	char_rom[ 950] <= 8'h0c; //     * *         
	char_rom[ 951] <= 8'h00; //                 

	// 0x77 'w'
	char_rom[ 952] <= 8'h00; //                 
	char_rom[ 953] <= 8'h00; //                 
	char_rom[ 954] <= 8'h63; // * *       * *   
	char_rom[ 955] <= 8'h6b; // * *   *   * *   
	char_rom[ 956] <= 8'h7f; // * * * * * * *   
	char_rom[ 957] <= 8'h7f; // * * * * * * *   
	char_rom[ 958] <= 8'h36; //   * *   * *     
	char_rom[ 959] <= 8'h00; //                 

	// 0x78 'x'
	char_rom[ 960] <= 8'h00; //                 
	char_rom[ 961] <= 8'h00; //                 
	char_rom[ 962] <= 8'h63; // * *       * *   
	char_rom[ 963] <= 8'h36; //   * *   * *     
	char_rom[ 964] <= 8'h1c; //     * * *       
	char_rom[ 965] <= 8'h36; //   * *   * *     
	char_rom[ 966] <= 8'h63; // * *       * *   
	char_rom[ 967] <= 8'h00; //                 

	// 0x79 'y'
	char_rom[ 968] <= 8'h00; //                 
	char_rom[ 969] <= 8'h00; //                 
	char_rom[ 970] <= 8'h33; // * *     * *     
	char_rom[ 971] <= 8'h33; // * *     * *     
	char_rom[ 972] <= 8'h33; // * *     * *     
	char_rom[ 973] <= 8'h3e; //   * * * * *     
	char_rom[ 974] <= 8'h30; //         * *     
	char_rom[ 975] <= 8'h1f; // * * * * *       

	// 0x7a 'z'
	char_rom[ 976] <= 8'h00; //                 
	char_rom[ 977] <= 8'h00; //                 
	char_rom[ 978] <= 8'h3f; // * * * * * *     
	char_rom[ 979] <= 8'h19; // *     * *       
	char_rom[ 980] <= 8'h0c; //     * *         
	char_rom[ 981] <= 8'h26; //   * *     *     
	char_rom[ 982] <= 8'h3f; // * * * * * *     
	char_rom[ 983] <= 8'h00; //                 

	// 0x7b '{'
	char_rom[ 984] <= 8'h38; //       * * *     
	char_rom[ 985] <= 8'h0c; //     * *         
	char_rom[ 986] <= 8'h0c; //     * *         
	char_rom[ 987] <= 8'h07; // * * *           
	char_rom[ 988] <= 8'h0c; //     * *         
	char_rom[ 989] <= 8'h0c; //     * *         
	char_rom[ 990] <= 8'h38; //       * * *     
	char_rom[ 991] <= 8'h00; //                 

	// 0x7c '|'
	char_rom[ 992] <= 8'h18; //       * *       
	char_rom[ 993] <= 8'h18; //       * *       
	char_rom[ 994] <= 8'h18; //       * *       
	char_rom[ 995] <= 8'h00; //                 
	char_rom[ 996] <= 8'h18; //       * *       
	char_rom[ 997] <= 8'h18; //       * *       
	char_rom[ 998] <= 8'h18; //       * *       
	char_rom[ 999] <= 8'h00; //                 

	// 0x7d '}'
	char_rom[1000] <= 8'h07; // * * *           
	char_rom[1001] <= 8'h0c; //     * *         
	char_rom[1002] <= 8'h0c; //     * *         
	char_rom[1003] <= 8'h38; //       * * *     
	char_rom[1004] <= 8'h0c; //     * *         
	char_rom[1005] <= 8'h0c; //     * *         
	char_rom[1006] <= 8'h07; // * * *           
	char_rom[1007] <= 8'h00; //                 

	// 0x7e '~'
	char_rom[1008] <= 8'h6e; //   * * *   * *   
	char_rom[1009] <= 8'h3b; // * *   * * *     
	char_rom[1010] <= 8'h00; //                 
	char_rom[1011] <= 8'h00; //                 
	char_rom[1012] <= 8'h00; //                 
	char_rom[1013] <= 8'h00; //                 
	char_rom[1014] <= 8'h00; //                 
	char_rom[1015] <= 8'h00; //                 

	// 0x7f ''
	char_rom[1016] <= 8'h00; //                 
	char_rom[1017] <= 8'h00; //                 
	char_rom[1018] <= 8'h00; //                 
	char_rom[1019] <= 8'h00; //                 
	char_rom[1020] <= 8'h00; //                 
	char_rom[1021] <= 8'h00; //                 
	char_rom[1022] <= 8'h00; //                 
	char_rom[1023] <= 8'h00; //                 
end

always @(posedge pxlclk) begin
	dout <= char_rom[{ascii, row}];
end

endmodule
