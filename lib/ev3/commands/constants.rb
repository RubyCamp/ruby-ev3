# see:
#   https://github.com/mindboards/ev3sources/blob/master/lms2012/c_com/source/c_com.h
#   https://github.com/mindboards/ev3sources/blob/master/lms2012/lms2012/source/bytecodes.h
module EV3
  module ArgumentSize
    BYTE = "\x81"
    SHORT = "\x82"
  end

  module Layers
    LAYER_0 = "\x00"
  end

  module CommandType
    DIRECT_COMMAND_REPLY = "\x00"     # Direct command, reply required
    DIRECT_COMMAND_NO_REPLY = "\x80"  # Direct command, reply not require
    DIRECT_REPLY = "\x02"             # Direct command reply OK
    DIRECT_REPLY_ERROR = "\x04"       # Direct command reply ERROR
  end

  module InputSubCodes
    GET_FORMAT = "\x02"
    CAL_MIN_MAX = "\x03"
    CAL_DEFAULT = "\x04"
    GET_TYPE_MODE = "\x05"
    GET_SYMBOL = "\x06"
    CAL_MIN = "\x07"
    CAL_MAX = "\x08"
    SETUP = "\x09"
    CLEAR_ALL = "\x0A"
    GET_RAW = "\x0B"
    GET_CONNECTION = "\x0C"
    STOP_ALL = "\x0D"
    GET_NAME = "\x15"
    GET_MODE_NAME = "\x16"
    SET_RAW = "\x17"
    GET_FIGURES = "\x18"
    GET_CHANGES = "\x19"
    CLR_CHANGES = "\x1A"
    READY_PCT = "\x1B"
    READY_RAW = "\x1C"
    READY_SI = "\x1D"
    GET_MIN_MAX = "\x1E"
    GET_BUMPS = "\x1F"
  end

  module UiWriteSubcodes
    LED = 27
  end

  module SoundSubCodes
    BREAK = 0
    TONE = 1
    PLAY = 2
    REPEAT = 3
  end

  module ReplyCodes
    SIZE1 = 0
    SIZE2 = 1
    MESSAGE_COUNTER1 = 2
    MESSAGE_COUNTER2 = 3
    REPLY = 4
    RESPONSE_BUFFER = 5
  end

  module ByteCodes
    #  \endverbatim \ref VM \verbatim
    #                                      0000....
    ERROR                     = "\x00" ##      0000
    NOP                       = "\x01" ##      0001
    PROGRAM_STOP              = "\x02" ##      0010
    PROGRAM_START             = "\x03" ##      0011
    OBJECT_STOP               = "\x04" ##      0100
    OBJECT_START              = "\x05" ##      0101
    OBJECT_TRIG               = "\x06" ##      0110
    OBJECT_WAIT               = "\x07" ##      0111
    RETURN                    = "\x08" ##      1000
    CALL                      = "\x09" ##      1001
    OBJECT_END                = "\x0A" ##      1010
    SLEEP                     = "\x0B" ##      1011
    PROGRAM_INFO              = "\x0C" ##      1100
    LABEL                     = "\x0D" ##      1101
    PROBE                     = "\x0E" ##      1110
    DO                        = "\x0F" ##      1111

    #  \endverbatim \ref cMath "MATH" \verbatim
    #                                      0001....
    #                  ADD                     00..
    ADD8                      = "\x10" ##        00
    ADD16                     = "\x11" ##        01
    ADD32                     = "\x12" ##        10
    ADDF                      = "\x13" ##        11
    #                  SUB                     01..
    SUB8                      = "\x14" ##        00
    SUB16                     = "\x15" ##        01
    SUB32                     = "\x16" ##        10
    SUBF                      = "\x17" ##        11
    #                  MUL                     10..
    MUL8                      = "\x18" ##        00
    MUL16                     = "\x19" ##        01
    MUL32                     = "\x1A" ##        10
    MULF                      = "\x1B" ##        11
    #                  DIV                     11..
    DIV8                      = "\x1C" ##        00
    DIV16                     = "\x1D" ##        01
    DIV32                     = "\x1E" ##        10
    DIVF                      = "\x1F" ##        11

    #  \endverbatim \ref Logic "LOGIC" \verbatim
    #      LOGIC                           0010....
    #                  OR                      00..
    OR8                       = "\x20" ##        00
    OR16                      = "\x21" ##        01
    OR32                      = "\x22" ##        10
    #                  AND                     01..
    AND8                      = "\x24" ##        00
    AND16                     = "\x25" ##        01
    AND32                     = "\x26" ##        10
    #                  XOR                     10..
    XOR8                      = "\x28" ##        00
    XOR16                     = "\x29" ##        01
    XOR32                     = "\x2A" ##        10
    #                  RL                      11..
    RL8                       = "\x2C" ##        00
    RL16                      = "\x2D" ##        01
    RL32                      = "\x2E" ##        10
    #  \endverbatim \ref cMove "MOVE" \verbatim
    INIT_BYTES                = "\x2F" ##      1111

    #      MOVE                            0011....
    #                  MOVE8_                  00..
    MOVE8_8                   = "\x30" ##        00
    MOVE8_16                  = "\x31" ##        01
    MOVE8_32                  = "\x32" ##        10
    MOVE8_F                   = "\x33" ##        11
    #                  MOVE16_                 01..
    MOVE16_8                  = "\x34" ##        00
    MOVE16_16                 = "\x35" ##        01
    MOVE16_32                 = "\x36" ##        10
    MOVE16_F                  = "\x37" ##        11
    #                  MOVE32_                 10..
    MOVE32_8                  = "\x38" ##        00
    MOVE32_16                 = "\x39" ##        01
    MOVE32_32                 = "\x3A" ##        10
    MOVE32_F                  = "\x3B" ##        11
    #                  MOVEF_                  11..
    MOVEF_8                   = "\x3C" ##        00
    MOVEF_16                  = "\x3D" ##        01
    MOVEF_32                  = "\x3E" ##        10
    MOVEF_F                   = "\x3F" ##        11

    #  \endverbatim \ref cBranch "BRANCH" \verbatim
    #      BRANCH                          010000..
    JR                        = "\x40" ##        00
    JR_FALSE                  = "\x41" ##        01
    JR_TRUE                   = "\x42" ##        10
    JR_NAN                    = "\x43" ##        11

    #  \endverbatim \ref cCompare "COMPARE" \verbatim
    #      COMPARE                         010.....
    #                  CP_LT                  001..
    CP_LT8                    = "\x44" ##        00
    CP_LT16                   = "\x45" ##        01
    CP_LT32                   = "\x46" ##        10
    CP_LTF                    = "\x47" ##        11
    #                  CP_GT                  010..
    CP_GT8                    = "\x48" ##        00
    CP_GT16                   = "\x49" ##        01
    CP_GT32                   = "\x4A" ##        10
    CP_GTF                    = "\x4B" ##        11
    #                  CP_EQ                  011..
    CP_EQ8                    = "\x4C" ##        00
    CP_EQ16                   = "\x4D" ##        01
    CP_EQ32                   = "\x4E" ##        10
    CP_EQF                    = "\x4F" ##        11
    #                  CP_NEQ                 100..
    CP_NEQ8                   = "\x50" ##        00
    CP_NEQ16                  = "\x51" ##        01
    CP_NEQ32                  = "\x52" ##        10
    CP_NEQF                   = "\x53" ##        11
    #                  CP_LTEQ                101..
    CP_LTEQ8                  = "\x54" ##        00
    CP_LTEQ16                 = "\x55" ##        01
    CP_LTEQ32                 = "\x56" ##        10
    CP_LTEQF                  = "\x57" ##        11
    #                  CP_GTEQ                110..
    CP_GTEQ8                  = "\x58" ##        00
    CP_GTEQ16                 = "\x59" ##        01
    CP_GTEQ32                 = "\x5A" ##        10
    CP_GTEQF                  = "\x5B" ##        11

    #  \endverbatim \ref Select "SELECT" \verbatim
    #      SELECT                          010111..
    SELECT8                   = "\x5C" ##        00
    SELECT16                  = "\x5D" ##        01
    SELECT32                  = "\x5E" ##        10
    SELECTF                   = "\x5F" ##        11


    #  \endverbatim \ref VM \verbatim
    SYSTEM                    = "\x60"
    PORT_CNV_OUTPUT           = "\x61"
    PORT_CNV_INPUT            = "\x62"
    NOTE_TO_FREQ              = "\x63"

    #  \endverbatim \ref cBranch "BRANCH" \verbatim
    #      BRANCH                          011000..
                                       ##?       00
                                       ##?       01
                                       ##?       10
                                       ##?       11
    #                  JR_LT                  001..
    JR_LT8                    = "\x64" ##        00
    JR_LT16                   = "\x65" ##        01
    JR_LT32                   = "\x66" ##        10
    JR_LTF                    = "\x67" ##        11
    #                  JR_GT                  010..
    JR_GT8                    = "\x68" ##        00
    JR_GT16                   = "\x69" ##        01
    JR_GT32                   = "\x6A" ##        10
    JR_GTF                    = "\x6B" ##        11
    #                  JR_EQ                  011..
    JR_EQ8                    = "\x6C" ##        00
    JR_EQ16                   = "\x6D" ##        01
    JR_EQ32                   = "\x6E" ##        10
    JR_EQF                    = "\x6F" ##        11
    #                  JR_NEQ                 100..
    JR_NEQ8                   = "\x70" ##        00
    JR_NEQ16                  = "\x71" ##        01
    JR_NEQ32                  = "\x72" ##        10
    JR_NEQF                   = "\x73" ##        11
    #                  JR_LTEQ                101..
    JR_LTEQ8                  = "\x74" ##        00
    JR_LTEQ16                 = "\x75" ##        01
    JR_LTEQ32                 = "\x76" ##        10
    JR_LTEQF                  = "\x77" ##        11
    #                  JR_GTEQ                110..
    JR_GTEQ8                  = "\x78" ##        00
    JR_GTEQ16                 = "\x79" ##        01
    JR_GTEQ32                 = "\x7A" ##        10
    JR_GTEQF                  = "\x7B" ##        11

    #  \endverbatim \ref VM \verbatim
    INFO                      = "\x7C" ##  01111100
    STRINGS                   = "\x7D" ##  01111101
    MEMORY_WRITE              = "\x7E" ##  01111110
    MEMORY_READ               = "\x7F" ##  01111111

    #      SYSTEM                          1.......

    #  \endverbatim \ref cUi "UI" \verbatim
    #      UI                              100000..
    UI_FLUSH                  = "\x80" ##        00
    UI_READ                   = "\x81" ##        01
    UI_WRITE                  = "\x82" ##        10
    UI_BUTTON                 = "\x83" ##        11
    UI_DRAW                   = "\x84" ##  10000100

    #  \endverbatim \ref cTimer "TIMER" \verbatim
    TIMER_WAIT                = "\x85" ##  10000101
    TIMER_READY               = "\x86" ##  10000110
    TIMER_READ                = "\x87" ##  10000111

    #  \endverbatim \ref VM \verbatim
    #      BREAKPOINT                      10001...
    BP0                       = "\x88" ##       000
    BP1                       = "\x89" ##       001
    BP2                       = "\x8A" ##       010
    BP3                       = "\x8B" ##       011
    BP_SET                    = "\x8C" ##  10001100
    MATH                      = "\x8D" ##  10001101
    RANDOM                    = "\x8E" ##  10001110

    #  \endverbatim \ref cTimer "TIMER" \verbatim
    TIMER_READ_US             = "\x8F" ##  10001111

    #  \endverbatim \ref cUi "UI" \verbatim
    KEEP_ALIVE                = "\x90" ##  10010000

    #  \endverbatim \ref cCom "COM" \verbatim
    #                                      100100..
    COM_READ                  = "\x91" ##        01
    COM_WRITE                 = "\x92" ##        10

    #  \endverbatim \ref cSound "SOUND" \verbatim
    #                                      100101..
    SOUND                     = "\x94" ##        00
    SOUND_TEST                = "\x95" ##        01
    SOUND_READY               = "\x96" ##        10

    #  \endverbatim \ref cInput "INPUT" \verbatim
    #
    INPUT_SAMPLE              = "\x97" ##  10010111

    #                                      10011...
    INPUT_DEVICE_LIST         = "\x98" ##       000
    INPUT_DEVICE              = "\x99" ##       001
    INPUT_READ                = "\x9A" ##       010
    INPUT_TEST                = "\x9B" ##       011
    INPUT_READY               = "\x9C" ##       100
    INPUT_READSI              = "\x9D" ##       101
    INPUT_READEXT             = "\x9E" ##       110
    INPUT_WRITE               = "\x9F" ##       111

    #  \endverbatim \ref cOutput "OUTT" \verbatim
    #                                      101.....
    OUTPUT_GET_TYPE           = "\xA0" ##     00000
    OUTPUT_SET_TYPE           = "\xA1" ##     00001
    OUTPUT_RESET              = "\xA2" ##     00010
    OUTPUT_STOP               = "\xA3" ##     00011
    OUTPUT_POWER              = "\xA4" ##     00100
    OUTPUT_SPEED              = "\xA5" ##     00101
    OUTPUT_START              = "\xA6" ##     00110
    OUTPUT_POLARITY           = "\xA7" ##     00111
    OUTPUT_READ               = "\xA8" ##     01000
    OUTPUT_TEST               = "\xA9" ##     01001
    OUTPUT_READY              = "\xAA" ##     01010
    OUTPUT_POSITION           = "\xAB" ##     01011
    OUTPUT_STEP_POWER         = "\xAC" ##     01100
    OUTPUT_TIME_POWER         = "\xAD" ##     01101
    OUTPUT_STEP_SPEED         = "\xAE" ##     01110
    OUTPUT_TIME_SPEED         = "\xAF" ##     01111

    OUTPUT_STEP_SYNC          = "\xB0" ##     10000
    OUTPUT_TIME_SYNC          = "\xB1" ##     10001
    OUTPUT_CLR_COUNT          = "\xB2" ##     10010
    OUTPUT_GET_COUNT          = "\xB3" ##     10011

    OUTPUT_PRG_STOP           = "\xB4" ##     10100

    #  \endverbatim \ref cMemory "MEMORY" \verbatim
    #                                      11000...
    FILE                      = "\xC0" ##       000
    ARRAY                     = "\xC1" ##       001
    ARRAY_WRITE               = "\xC2" ##       010
    ARRAY_READ                = "\xC3" ##       011
    ARRAY_APPEND              = "\xC4" ##       100
    MEMORY_USAGE              = "\xC5" ##       101
    FILENAME                  = "\xC6" ##       110

    #  \endverbatim \ref cMove "READ" \verbatim
    #                                      110010..
    READ8                     = "\xC8" ##        00
    READ16                    = "\xC9" ##        01
    READ32                    = "\xCA" ##        10
    READF                     = "\xCB" ##        11

    #  \endverbatim \ref cMove "WRITE" \verbatim
    #                                      110011..
    WRITE8                    = "\xCC" ##        00
    WRITE16                   = "\xCD" ##        01
    WRITE32                   = "\xCE" ##        10
    WRITEF                    = "\xCF" ##        11

    #  \endverbatim \ref cCom "COM" \verbatim
    #                                      11010...
    COM_READY                 = "\xD0" ##       000
    COM_READDATA              = "\xD1" ##       001
    COM_WRITEDATA             = "\xD2" ##       010
    COM_GET                   = "\xD3" ##       011
    COM_SET                   = "\xD4" ##       100
    COM_TEST                  = "\xD5" ##       101
    COM_REMOVE                = "\xD6" ##       110
    COM_WRITEFILE             = "\xD7" ##       111

    #                                      11011...
    MAILBOX_OPEN              = "\xD8" ##       000
    MAILBOX_WRITE             = "\xD9" ##       001
    MAILBOX_READ              = "\xDA" ##       010
    MAILBOX_TEST              = "\xDB" ##       011
    MAILBOX_READY             = "\xDC" ##       100
    MAILBOX_CLOSE             = "\xDD" ##       101

    #      SPARE                           111.....

    #  \endverbatim \ref TST \verbatim
    TST                       = "\xFF" ##  11111111
  end
end
