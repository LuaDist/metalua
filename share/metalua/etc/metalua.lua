LuaQ  ]   @C:/Users/drahosp/Desktop/Batteries/bin/_batteries/tmp/metalua-0.5/src/compiler/metalua.mlua     *           A@  @ $   e          �       require    metalua.runtime            *     t      A@  @    A�  @    A�  @ @   � � @   
   J   �       �� 
A JA IAC�I�C�IAD�� �� �� I��IAE��A ��E���E��AD��  ܁ ����AF��A ɁF���F��AD�  A � ���AG�
 	�G�	�G�	BD�	H�J IBH�I�H�I�H�II�� �BI���I���H���I�� �J��BJ���H�ɂJ�
 	�J�	K�	�H�	CK�J I�K�I�K�I�H�IL�� �CL���L���H���L�� �M��CM���H�ɃM�
 	�M�	N�	DD�	DN�J�  I�N�I�H�I�N��D �O��DO���O��D    � �����O�	P�"A ܀ ǀ �        �  �e  A   � A      require    metalua.compiler    metalua.clopts    metalua.mlc_xcall    AST_COMPILE_ERROR_NUMBER       �   RUNTIME_ERROR_NUMBER       �   BYTECODE_SYNTHESE_ERROR_NUMBER       Y�   parser    clopts    short    f    long    file    type    string    action    File    usage "   load a file to compile and/or run    l    library    Library &   load a libary from the standard paths    e    literal    Literal $   load a literal piece of source code    o    output .   set the target name of the next compiled file    x    run    boolean H   execute the compiled file instead of saving it (unless -o is also used)    i    interactive 5   run an interactive loop after having run other files    v    verbose    verbose mode    a 
   print-ast .   print the AST resulting from file compilation    A    print-ast-lineinfo G   print the AST resulting from file compilation, including lineinfo data    S 
   print-src I   print the AST resulting from file compilation, as re-gerenerated sources    b 	   metabugs 4   show syntax errors as compile-time execution errors    s 
   sharpbang E   set a first line to add to compiled file, typically "#!/bin/env mlr"    no-runtime 5   prevent the automatic requirement of metalua runtime        p    * ,   pass all remaining arguments to the program   
Compile and/or execute metalua programs. Parameters passed to the
compiler should be prefixed with an option flag, hinting what must be
done with them: take tham as file names to compile, as library names
to load, as parameters passed to the running program... When option
flags are absent, metalua tries to adopt a "Do What I Mean" approach:

- if no code (no library, no literal expression and no file) is
  specified, the first flag-less parameter is taken as a file name to
  load.

- if no code and no parameter is passed, an interactive loop is
  started.

- if a target file is specified with --output, the program is not
  executed by default, unless a --run flag forces it to. Conversely,
  if no --output target is specified, the code is run unless ++run
  forbids it.
                  d          ^   �                      E   F@� �   �@� � � �   �@� ] �^    �       table    insert    tag                                               arg     
         chunks    kind                         kind              chunks     ?   ?       E   F@� �   �   \��H    �       table    icat        ?   ?   ?   ?   ?   ?   ?         newargs              runargs     W   �    �     e   �  d       �@@ �   ��� � ��  �  A@   �@  �   �  @A����A �   ����  ��AƀA  ���� � A @ �@�� � 
A� 	�B�@ "A� �@� �   �   �  @A��� C @C� �� � �� �@ 	�C�� D @C���@D �@  � �� � �� �@ 	�C��   �� E � �� �A D  @(� � A� ��  �A��� B  ���� E� � \� W��@ �c  ��ƂBW �@ �c  @�B@C@ �c   �T W �@ �c  ��B� �C �CF��C� ɃF�� �C� 
D� 	G�@ "D� �C @  ��  ��� E� � \� W��@ �c  ��ƂBW@�@ �c  @�B@C@ �c   �T W �@ �c  ��E� F��� \� @  ��   �� E� � \� W��@ �c  @�ƂBW��@ �c   �B@C@ �c  �	�T W �@ �c  ��E� F�� \� @  �   �JC ICF��C �CH��� 
D  	�H��C� 
� @�"D� �C �C  ɃH�bC @�A	 � U��IB��A	 � U���@��� ��  � ��B	 �	 �B B  @���	 �
 �  A@�� [C�  �AC
 �B ��
 ��J� �B I���  ��K�  ��B�!A  ���   @��  �K@�� E�  F���ʁ� �AL��H���  �A� \A��L A  � ��L   �
� � A A A @ ���	 A� ��  �A���� ��B  B�  ��B��B�B� ��BN�B�L   ���  BN@��� �� B @��  BN@��� �� B !A  ��O   �� � AA A � A� A A @ ���	 A� ��  �A���� ��B  B�  ��B��B�B� ��BN�BB E ��\ B  !A  @�AP   � � � A� A ���  �K@ � �A �AF�
B� 	�F�A� "B� JB� IG��� bB� �A A � Q@ � �  FAQ Z  ��FAQ �� ��  ��A���� ����A  � ��A ��U����� ����A  � ����� U���� �FAD Z  @	�@� � �AD \A�EA F���AD �� \��ZA   ��A	  @ B�A �A�@ �A�ˁ��A �AQ �  @�Ł
 ��� ܁ W@���Ł �
 �UA �BD �B U�A�FD Z  ��@� �� \A E� F��� \�  ��  �WƁA �A    ��  � ����� �A  �A $�    � � @ ����A   �EB F��KB�� \B�E�
 F���� \B c  FC Z   �@� � \A E� �A \A E� F�\A� @� �� \A  � d      parser    verbose    raw options: %s    table 	   tostring            params    remove       �?%   Param %q considered as a source file    tag    File    interactive  3   Nothing to compile nor run, force interactive loop    run    output /   No output file specified; I'll run the program    mlc 	   metabugs    values    Compiling %s    type    Library    Call    Id    require    String    Literal 
   mlc_xcall    client_literal    client_file 	   Function    Dots    source    @    error 	   mismatch    printf    Cannot compile %s:
%s    no msg    os    exit    AST_COMPILE_ERROR_NUMBER    origin    insert    shallow_copy 	   override    Return 
   print-ast    print-ast-lineinfo    Resulting AST:    ivalues    --- AST From %s: ---    nohash        @   print       T@   indent1 
   print-src    Resulting sources:    metalua.ast_to_string    --- Source From %s: ---    ast_to_string    no-runtime 9   Prevent insertion of command "require 'metalua.runtime'"    metalua.runtime    luacstring_of_ast 
   sharpbang    Adding sharp-bang directive %q 	   strmatch    ^#!    #!    
$    
    Saving to file %q    io    open    wb    can't open output file:     write    close    getenv    OS    Windows_NT    pcall    execute    chmod a+x "    "    Running    function_of_luacstring    icat    xpcall    stderr    RUNTIME_ERROR_NUMBER    Starting REPL loop    metalua.metaloop 	   metaloop    Done        ^   b      D   F � Z   ��E@  ��  �   �  � �   ]   ^    �       verbose    printf    [      ]        _   _   _   _   `   `   `   `   `   `   `   `   `         fmt              cfg     �   �        @   �   �@  ƀ��  A ܀�  U � ^   �       
    debug 
   traceback            @       �   �   �   �   �   �   �   �   �   �   �         errmsg     
           �   �           E   � � \         �       unpack        �   �   �   �   �   �   �             f    runargs �  Y   Y   Y   b   b   d   d   d   e   e   e   e   e   e   e   k   k   k   k   k   k   k   l   l   l   l   l   m   m   m   m   n   n   n   n   n   n   n   s   s   s   s   s   s   s   t   t   t   u   |   |   |   |   |   |   }   }   }   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   #      cfg    �     verb_print    �  	   the_file    &      code <   �  
   last_file @   �     (for generator) C   �      (for state) C   �      (for control) C   �      x D   �      st L   �      ast L   �      .3.v M   �      .1.submatch.2 N   t      l N   t      .1.submatch.2 u   �      e u   �      .1.submatch.2 �   �      f �   �      c �   �      (for generator)   *     (for state)   *     (for control)   *     x   (     (for generator) 6  Q     (for state) 6  Q     (for control) 6  Q     x 7  O  	   bytecode l  �     shbang q  �     file �  �     err_msg �  �     f �  �     print_traceback �  �     st �  �     msg �  �        chunks    runargs t                                    	   	   
   
                  U                                                                                    !                $   "   "   "   #   '   %   %   %   &   +   )   )   )   *   .   ,   ,   ,   -   1   /   /   /   0   4   2   2   2   3   7   5   5   5   6   :   8   8   8   9   =   ;   ;   <   A   >   >   >   ?   ?   ?   @   U   U      U   �   �   �                 chunks    s      runargs    s   
   acc_chunk    s      main p   s          *   *       *   *       *   *           