; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [175 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [350 x i64] [
	i64 98382396393917666, ; 0: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 47
	i64 120698629574877762, ; 1: Mono.Android => 0x1accec39cafe242 => 174
	i64 131669012237370309, ; 2: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 51
	i64 196720943101637631, ; 3: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 113
	i64 210515253464952879, ; 4: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 64
	i64 232391251801502327, ; 5: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 81
	i64 435118502366263740, ; 6: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x609d9f8f8bdb9bc => 82
	i64 486223428996552534, ; 7: ZstdSharp.dll => 0x6bf69a1eecfd756 => 90
	i64 545109961164950392, ; 8: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 7
	i64 560278790331054453, ; 9: System.Reflection.Primitives => 0x7c6829760de3975 => 134
	i64 595053104451889001, ; 10: MySql.Data => 0x8420da551592769 => 53
	i64 702024105029695270, ; 11: System.Drawing.Common => 0x9be17343c0e7726 => 56
	i64 750875890346172408, ; 12: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 162
	i64 799765834175365804, ; 13: System.ComponentModel.dll => 0xb1956c9f18442ac => 101
	i64 849051935479314978, ; 14: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 10
	i64 872800313462103108, ; 15: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 69
	i64 1010599046655515943, ; 16: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 134
	i64 1120440138749646132, ; 17: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 86
	i64 1121665720830085036, ; 18: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 18
	i64 1268860745194512059, ; 19: System.Drawing.dll => 0x119be62002c19ebb => 108
	i64 1369545283391376210, ; 20: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 77
	i64 1476839205573959279, ; 21: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 120
	i64 1486715745332614827, ; 22: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 48
	i64 1513467482682125403, ; 23: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 173
	i64 1537168428375924959, ; 24: System.Threading.Thread.dll => 0x15551e8a954ae0df => 162
	i64 1556147632182429976, ; 25: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 16
	i64 1624659445732251991, ; 26: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 62
	i64 1628611045998245443, ; 27: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 74
	i64 1731380447121279447, ; 28: Newtonsoft.Json => 0x18071957e9b889d7 => 54
	i64 1743969030606105336, ; 29: System.Memory.dll => 0x1833d297e88f2af8 => 115
	i64 1767386781656293639, ; 30: System.Private.Uri.dll => 0x188704e9f5582107 => 129
	i64 1769105627832031750, ; 31: Google.Protobuf => 0x188d203205129a06 => 36
	i64 1795316252682057001, ; 32: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 61
	i64 1825687700144851180, ; 33: System.Runtime.InteropServices.RuntimeInformation.dll => 0x1956254a55ef08ec => 138
	i64 1835311033149317475, ; 34: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 6
	i64 1836611346387731153, ; 35: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 81
	i64 1875417405349196092, ; 36: System.Drawing.Primitives => 0x1a06d2319b6c713c => 107
	i64 1881198190668717030, ; 37: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 28
	i64 1897575647115118287, ; 38: Xamarin.AndroidX.Security.SecurityCrypto => 0x1a558aff4cba86cf => 82
	i64 1920760634179481754, ; 39: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 49
	i64 1959996714666907089, ; 40: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 28
	i64 1972385128188460614, ; 41: System.Security.Cryptography.Algorithms => 0x1b5f51d2edefbe46 => 148
	i64 1981742497975770890, ; 42: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 73
	i64 1983698669889758782, ; 43: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 2
	i64 2019660174692588140, ; 44: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 20
	i64 2102659300918482391, ; 45: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 107
	i64 2133195048986300728, ; 46: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 54
	i64 2262844636196693701, ; 47: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 69
	i64 2287834202362508563, ; 48: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 94
	i64 2302323944321350744, ; 49: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 24
	i64 2315304989185124968, ; 50: System.IO.FileSystem.dll => 0x20219d9ee311aa68 => 112
	i64 2329709569556905518, ; 51: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 72
	i64 2335503487726329082, ; 52: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 158
	i64 2337758774805907496, ; 53: System.Runtime.CompilerServices.Unsafe => 0x207163383edbc828 => 136
	i64 2470498323731680442, ; 54: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 65
	i64 2497223385847772520, ; 55: System.Runtime => 0x22a7eb7046413568 => 145
	i64 2547086958574651984, ; 56: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 60
	i64 2602673633151553063, ; 57: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 27
	i64 2632269733008246987, ; 58: System.Net.NameResolution => 0x2487b36034f808cb => 118
	i64 2656907746661064104, ; 59: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 42
	i64 2662981627730767622, ; 60: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 2
	i64 2783046991838674048, ; 61: System.Runtime.CompilerServices.Unsafe.dll => 0x269f5e7e6dc37c80 => 136
	i64 2815524396660695947, ; 62: System.Security.AccessControl => 0x2712c0857f68238b => 146
	i64 2851879596360956261, ; 63: System.Configuration.ConfigurationManager => 0x2793e9620b477965 => 55
	i64 2895129759130297543, ; 64: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 7
	i64 3017704767998173186, ; 65: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 86
	i64 3110390492489056344, ; 66: System.Security.Cryptography.Csp.dll => 0x2b2a53ac61900058 => 149
	i64 3281594302220646930, ; 67: System.Security.Principal => 0x2d8a90a198ceba12 => 155
	i64 3289520064315143713, ; 68: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 71
	i64 3311221304742556517, ; 69: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 127
	i64 3325875462027654285, ; 70: System.Runtime.Numerics => 0x2e27e21c8958b48d => 142
	i64 3328853167529574890, ; 71: System.Net.Sockets.dll => 0x2e327651a008c1ea => 124
	i64 3344514922410554693, ; 72: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 89
	i64 3429672777697402584, ; 73: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 51
	i64 3494946837667399002, ; 74: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 40
	i64 3522470458906976663, ; 75: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 83
	i64 3551103847008531295, ; 76: System.Private.CoreLib.dll => 0x31480e226177735f => 171
	i64 3567343442040498961, ; 77: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 22
	i64 3571415421602489686, ; 78: System.Runtime.dll => 0x319037675df7e556 => 145
	i64 3638003163729360188, ; 79: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 41
	i64 3647754201059316852, ; 80: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 167
	i64 3655542548057982301, ; 81: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 40
	i64 3716579019761409177, ; 82: netstandard.dll => 0x3393f0ed5c8c5c99 => 170
	i64 3727469159507183293, ; 83: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 80
	i64 3869221888984012293, ; 84: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 44
	i64 3890352374528606784, ; 85: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 49
	i64 3919223565570527920, ; 86: System.Security.Cryptography.Encoding => 0x3663e111652bd2b0 => 150
	i64 3933965368022646939, ; 87: System.Net.Requests => 0x369840a8bfadc09b => 121
	i64 3966267475168208030, ; 88: System.Memory => 0x370b03412596249e => 115
	i64 4009997192427317104, ; 89: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 144
	i64 4073500526318903918, ; 90: System.Private.Xml.dll => 0x3887fb25779ae26e => 131
	i64 4120493066591692148, ; 91: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 33
	i64 4154383907710350974, ; 92: System.ComponentModel => 0x39a7562737acb67e => 101
	i64 4167269041631776580, ; 93: System.Threading.ThreadPool => 0x39d51d1d3df1cf44 => 163
	i64 4168469861834746866, ; 94: System.Security.Claims.dll => 0x39d96140fb94ebf2 => 147
	i64 4187479170553454871, ; 95: System.Linq.Expressions => 0x3a1cea1e912fa117 => 113
	i64 4205801962323029395, ; 96: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 100
	i64 4356591372459378815, ; 97: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 30
	i64 4679594760078841447, ; 98: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 0
	i64 4794310189461587505, ; 99: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 60
	i64 4795410492532947900, ; 100: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 83
	i64 4809057822547766521, ; 101: System.Drawing => 0x42bd349c3145ecf9 => 108
	i64 4814660307502931973, ; 102: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 118
	i64 4853321196694829351, ; 103: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 141
	i64 5032256205035195147, ; 104: MySql.Data.dll => 0x45d62a5b3fe0cb0b => 53
	i64 5081566143765835342, ; 105: System.Resources.ResourceManager.dll => 0x4685597c05d06e4e => 135
	i64 5099468265966638712, ; 106: System.Resources.ResourceManager => 0x46c4f35ea8519678 => 135
	i64 5103417709280584325, ; 107: System.Collections.Specialized => 0x46d2fb5e161b6285 => 96
	i64 5182934613077526976, ; 108: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 96
	i64 5262971552273843408, ; 109: System.Security.Principal.dll => 0x4909d4be0c44c4d0 => 155
	i64 5278787618751394462, ; 110: System.Net.WebClient.dll => 0x4942055efc68329e => 125
	i64 5290786973231294105, ; 111: System.Runtime.Loader => 0x496ca6b869b72699 => 141
	i64 5423376490970181369, ; 112: System.Runtime.InteropServices.RuntimeInformation => 0x4b43b42f2b7b6ef9 => 138
	i64 5471532531798518949, ; 113: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 26
	i64 5488847537322884930, ; 114: System.Windows.Extensions => 0x4c2c4dc108687f42 => 59
	i64 5522859530602327440, ; 115: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 29
	i64 5570799893513421663, ; 116: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 110
	i64 5573260873512690141, ; 117: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 153
	i64 5650097808083101034, ; 118: System.Security.Cryptography.Algorithms.dll => 0x4e692e055d01a56a => 148
	i64 5692067934154308417, ; 119: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 85
	i64 5812387745074149618, ; 120: K4os.Compression.LZ4.dll => 0x50a9bfdbd9fa78f2 => 37
	i64 5979151488806146654, ; 121: System.Formats.Asn1 => 0x52fa3699a489d25e => 109
	i64 5984759512290286505, ; 122: System.Security.Cryptography.Primitives => 0x530e23115c33dba9 => 151
	i64 6068057819846744445, ; 123: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 23
	i64 6200764641006662125, ; 124: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 23
	i64 6222399776351216807, ; 125: System.Text.Json.dll => 0x565a67a0ffe264a7 => 159
	i64 6251069312384999852, ; 126: System.Transactions.Local => 0x56c0426b870da1ac => 165
	i64 6284145129771520194, ; 127: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 132
	i64 6357457916754632952, ; 128: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 34
	i64 6401687960814735282, ; 129: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 72
	i64 6478287442656530074, ; 130: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 11
	i64 6548213210057960872, ; 131: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 68
	i64 6560151584539558821, ; 132: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 46
	i64 6617685658146568858, ; 133: System.Text.Encoding.CodePages => 0x5bd6be0b4905fa9a => 156
	i64 6743165466166707109, ; 134: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 19
	i64 6777482997383978746, ; 135: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 22
	i64 6786606130239981554, ; 136: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 106
	i64 6814185388980153342, ; 137: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 168
	i64 6876862101832370452, ; 138: System.Xml.Linq => 0x5f6f85a57d108914 => 166
	i64 6894844156784520562, ; 139: System.Numerics.Vectors => 0x5faf683aead1ad72 => 127
	i64 7083547580668757502, ; 140: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 130
	i64 7112547816752919026, ; 141: System.IO.FileSystem => 0x62b4d88e3189b1f2 => 112
	i64 7220009545223068405, ; 142: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 26
	i64 7270811800166795866, ; 143: System.Linq => 0x64e71ccf51a90a5a => 114
	i64 7316205155833392065, ; 144: Microsoft.Win32.Primitives => 0x658861d38954abc1 => 93
	i64 7377312882064240630, ; 145: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 100
	i64 7451202609009583483, ; 146: K4os.Hash.xxHash => 0x6767fd4b737ae57b => 39
	i64 7488575175965059935, ; 147: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 166
	i64 7489048572193775167, ; 148: System.ObjectModel => 0x67ee71ff6b419e3f => 128
	i64 7592577537120840276, ; 149: System.Diagnostics.Process => 0x695e410af5b2aa54 => 105
	i64 7654504624184590948, ; 150: System.Net.Http => 0x6a3a4366801b8264 => 117
	i64 7708790323521193081, ; 151: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 17
	i64 7714652370974252055, ; 152: System.Private.CoreLib => 0x6b0ff375198b9c17 => 171
	i64 7735176074855944702, ; 153: Microsoft.CSharp => 0x6b58dda848e391fe => 92
	i64 7735352534559001595, ; 154: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 88
	i64 7836164640616011524, ; 155: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 62
	i64 8031450141206250471, ; 156: System.Runtime.Intrinsics.dll => 0x6f757159d9dc03e7 => 140
	i64 8064050204834738623, ; 157: System.Collections.dll => 0x6fe942efa61731bf => 97
	i64 8083354569033831015, ; 158: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 71
	i64 8085230611270010360, ; 159: System.Net.Http.Json.dll => 0x703482674fdd05f8 => 116
	i64 8087206902342787202, ; 160: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 104
	i64 8167236081217502503, ; 161: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 172
	i64 8185542183669246576, ; 162: System.Collections => 0x7198e33f4794aa70 => 97
	i64 8246048515196606205, ; 163: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 52
	i64 8264926008854159966, ; 164: System.Diagnostics.Process.dll => 0x72b2ea6a64a3a25e => 105
	i64 8290740647658429042, ; 165: System.Runtime.Extensions => 0x730ea0b15c929a72 => 137
	i64 8368701292315763008, ; 166: System.Security.Cryptography => 0x7423997c6fd56140 => 153
	i64 8400357532724379117, ; 167: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 79
	i64 8410671156615598628, ; 168: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 133
	i64 8476857680833348370, ; 169: System.Security.Permissions.dll => 0x75a3d925fd9d0312 => 58
	i64 8563666267364444763, ; 170: System.Private.Uri => 0x76d841191140ca5b => 129
	i64 8614108721271900878, ; 171: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 21
	i64 8626175481042262068, ; 172: Java.Interop => 0x77b654e585b55834 => 172
	i64 8638972117149407195, ; 173: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 92
	i64 8639588376636138208, ; 174: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 78
	i64 8677882282824630478, ; 175: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 21
	i64 8725526185868997716, ; 176: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 104
	i64 8941376889969657626, ; 177: System.Xml.XDocument => 0x7c1626e87187471a => 168
	i64 9045785047181495996, ; 178: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 31
	i64 9138683372487561558, ; 179: System.Security.Cryptography.Csp => 0x7ed3201bc3e3d156 => 149
	i64 9286073997824813334, ; 180: BouncyCastle.Cryptography => 0x80dec319ee56e916 => 35
	i64 9312692141327339315, ; 181: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 85
	i64 9324707631942237306, ; 182: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 61
	i64 9575902398040817096, ; 183: Xamarin.Google.Crypto.Tink.Android.dll => 0x84e4707ee708bdc8 => 87
	i64 9659729154652888475, ; 184: System.Text.RegularExpressions => 0x860e407c9991dd9b => 160
	i64 9678050649315576968, ; 185: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 65
	i64 9702891218465930390, ; 186: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 95
	i64 9808709177481450983, ; 187: Mono.Android.dll => 0x881f890734e555e7 => 174
	i64 9956195530459977388, ; 188: Microsoft.Maui => 0x8a2b8315b36616ac => 50
	i64 9991543690424095600, ; 189: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 6
	i64 9998685624638532270, ; 190: K4os.Hash.xxHash.dll => 0x8ac27799ad626aae => 39
	i64 10038780035334861115, ; 191: System.Net.Http.dll => 0x8b50e941206af13b => 117
	i64 10051358222726253779, ; 192: System.Private.Xml => 0x8b7d990c97ccccd3 => 131
	i64 10092835686693276772, ; 193: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 48
	i64 10143853363526200146, ; 194: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 3
	i64 10229024438826829339, ; 195: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 68
	i64 10236703004850800690, ; 196: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 123
	i64 10245369515835430794, ; 197: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 133
	i64 10364469296367737616, ; 198: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 132
	i64 10406448008575299332, ; 199: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 89
	i64 10430153318873392755, ; 200: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 66
	i64 10506226065143327199, ; 201: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 1
	i64 10670374202010151210, ; 202: Microsoft.Win32.Primitives.dll => 0x9414c8cd7b4ea92a => 93
	i64 10714184849103829812, ; 203: System.Runtime.Extensions.dll => 0x94b06e5aa4b4bb34 => 137
	i64 10785150219063592792, ; 204: System.Net.Primitives => 0x95ac8cfb68830758 => 120
	i64 10885087467875303060, ; 205: K4os.Compression.LZ4.Streams => 0x970f99615fc37e94 => 38
	i64 11002576679268595294, ; 206: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 45
	i64 11009005086950030778, ; 207: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 50
	i64 11103970607964515343, ; 208: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 12
	i64 11162124722117608902, ; 209: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 84
	i64 11220793807500858938, ; 210: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 15
	i64 11226290749488709958, ; 211: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 46
	i64 11340910727871153756, ; 212: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 67
	i64 11341245327015630248, ; 213: System.Configuration.ConfigurationManager.dll => 0x9d643289535355a8 => 55
	i64 11485890710487134646, ; 214: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 139
	i64 11513602507638267977, ; 215: System.IO.Pipelines.dll => 0x9fc8887aa0d36049 => 57
	i64 11518296021396496455, ; 216: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 13
	i64 11529969570048099689, ; 217: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 84
	i64 11530571088791430846, ; 218: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 44
	i64 11597940890313164233, ; 219: netstandard => 0xa0f429ca8d1805c9 => 170
	i64 11705530742807338875, ; 220: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 9
	i64 12040886584167504988, ; 221: System.Net.ServicePoint => 0xa719d28d8e121c5c => 123
	i64 12145679461940342714, ; 222: System.Text.Json => 0xa88e1f1ebcb62fba => 159
	i64 12201331334810686224, ; 223: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 144
	i64 12313367145828839434, ; 224: System.IO.Pipelines => 0xaae1de2e1c17f00a => 57
	i64 12451044538927396471, ; 225: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 70
	i64 12466513435562512481, ; 226: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 75
	i64 12475113361194491050, ; 227: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 34
	i64 12517810545449516888, ; 228: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 106
	i64 12538491095302438457, ; 229: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 63
	i64 12550732019250633519, ; 230: System.IO.Compression => 0xae2d28465e8e1b2f => 111
	i64 12681088699309157496, ; 231: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 14
	i64 12700543734426720211, ; 232: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 64
	i64 12708922737231849740, ; 233: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 157
	i64 12823819093633476069, ; 234: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 27
	i64 12843321153144804894, ; 235: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 47
	i64 12859557719246324186, ; 236: System.Net.WebHeaderCollection.dll => 0xb276539ce04f41da => 126
	i64 12963446364377008305, ; 237: System.Drawing.Common.dll => 0xb3e769c8fd8548b1 => 56
	i64 13008891852857511043, ; 238: FeelingsApp => 0xb488de37530b8c83 => 91
	i64 13068258254871114833, ; 239: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 143
	i64 13162471042547327635, ; 240: System.Security.Permissions => 0xb6aa7dace9662293 => 58
	i64 13221551921002590604, ; 241: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 1
	i64 13222659110913276082, ; 242: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 15
	i64 13343850469010654401, ; 243: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 173
	i64 13381594904270902445, ; 244: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 9
	i64 13431476299110033919, ; 245: System.Net.WebClient => 0xba663087f18829ff => 125
	i64 13465488254036897740, ; 246: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 88
	i64 13467053111158216594, ; 247: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 29
	i64 13540124433173649601, ; 248: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 30
	i64 13545416393490209236, ; 249: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 13
	i64 13572454107664307259, ; 250: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 80
	i64 13710614125866346983, ; 251: System.Security.AccessControl.dll => 0xbe45e2e7d0b769e7 => 146
	i64 13717397318615465333, ; 252: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 99
	i64 13755568601956062840, ; 253: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 8
	i64 13814445057219246765, ; 254: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 11
	i64 13881769479078963060, ; 255: System.Console.dll => 0xc0a5f3cade5c6774 => 102
	i64 13882652712560114096, ; 256: System.Windows.Extensions.dll => 0xc0a91716b04239b0 => 59
	i64 13959074834287824816, ; 257: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 70
	i64 14100563506285742564, ; 258: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 3
	i64 14124974489674258913, ; 259: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 63
	i64 14125464355221830302, ; 260: System.Threading.dll => 0xc407bafdbc707a9e => 164
	i64 14254574811015963973, ; 261: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 157
	i64 14327709162229390963, ; 262: System.Security.Cryptography.X509Certificates => 0xc6d63f9253cade73 => 152
	i64 14461014870687870182, ; 263: System.Net.Requests.dll => 0xc8afd8683afdece6 => 121
	i64 14464374589798375073, ; 264: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 24
	i64 14522721392235705434, ; 265: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 5
	i64 14551742072151931844, ; 266: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 158
	i64 14561513370130550166, ; 267: System.Security.Cryptography.Primitives.dll => 0xca14e3428abb8d96 => 151
	i64 14622043554576106986, ; 268: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 143
	i64 14669215534098758659, ; 269: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 42
	i64 14705122255218365489, ; 270: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 16
	i64 14744092281598614090, ; 271: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 32
	i64 14832630590065248058, ; 272: System.Security.Claims => 0xcdd816ef5d6e873a => 147
	i64 14852515768018889994, ; 273: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 67
	i64 14892012299694389861, ; 274: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 33
	i64 14904040806490515477, ; 275: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 0
	i64 14912225920358050525, ; 276: System.Security.Principal.Windows => 0xcef2de7759506add => 154
	i64 14935719434541007538, ; 277: System.Text.Encoding.CodePages.dll => 0xcf4655b160b702b2 => 156
	i64 14954917835170835695, ; 278: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 43
	i64 14984936317414011727, ; 279: System.Net.WebHeaderCollection => 0xcff5302fe54ff34f => 126
	i64 14987728460634540364, ; 280: System.IO.Compression.dll => 0xcfff1ba06622494c => 111
	i64 15015154896917945444, ; 281: System.Net.Security.dll => 0xd0608bd33642dc64 => 122
	i64 15024878362326791334, ; 282: System.Net.Http.Json => 0xd0831743ebf0f4a6 => 116
	i64 15076659072870671916, ; 283: System.ObjectModel.dll => 0xd13b0d8c1620662c => 128
	i64 15111608613780139878, ; 284: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 17
	i64 15115185479366240210, ; 285: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 110
	i64 15133485256822086103, ; 286: System.Linq.dll => 0xd204f0a9127dd9d7 => 114
	i64 15227001540531775957, ; 287: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 41
	i64 15370334346939861994, ; 288: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 66
	i64 15391712275433856905, ; 289: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 43
	i64 15527772828719725935, ; 290: System.Console => 0xd77dbb1e38cd3d6f => 102
	i64 15536481058354060254, ; 291: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 4
	i64 15541854775306130054, ; 292: System.Security.Cryptography.X509Certificates.dll => 0xd7afc292e8d49286 => 152
	i64 15557562860424774966, ; 293: System.Net.Sockets => 0xd7e790fe7a6dc536 => 124
	i64 15582737692548360875, ; 294: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 74
	i64 15609085926864131306, ; 295: System.dll => 0xd89e9cf3334914ea => 169
	i64 15620612276725577442, ; 296: BouncyCastle.Cryptography.dll => 0xd8c7901aa85576e2 => 35
	i64 15661133872274321916, ; 297: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 167
	i64 15664356999916475676, ; 298: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 4
	i64 15743187114543869802, ; 299: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 12
	i64 15783653065526199428, ; 300: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 5
	i64 15847085070278954535, ; 301: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 161
	i64 16018552496348375205, ; 302: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 119
	i64 16154507427712707110, ; 303: System => 0xe03056ea4e39aa26 => 169
	i64 16219561732052121626, ; 304: System.Net.Security => 0xe1177575db7c781a => 122
	i64 16288847719894691167, ; 305: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 18
	i64 16321164108206115771, ; 306: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 45
	i64 16337011941688632206, ; 307: System.Security.Principal.Windows.dll => 0xe2b8b9cdc3aa638e => 154
	i64 16454459195343277943, ; 308: System.Net.NetworkInformation => 0xe459fb756d988f77 => 119
	i64 16637862623548895820, ; 309: K4os.Compression.LZ4 => 0xe6e58fe7aa61724c => 37
	i64 16649148416072044166, ; 310: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 52
	i64 16677317093839702854, ; 311: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 79
	i64 16737807731308835127, ; 312: System.Runtime.Intrinsics => 0xe848a3736f733137 => 140
	i64 16856067890322379635, ; 313: System.Data.Common.dll => 0xe9ecc87060889373 => 103
	i64 16873478996345296124, ; 314: K4os.Compression.LZ4.Streams.dll => 0xea2aa3bf662d14fc => 38
	i64 16890310621557459193, ; 315: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 160
	i64 16942731696432749159, ; 316: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 25
	i64 16998075588627545693, ; 317: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 77
	i64 17008137082415910100, ; 318: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 95
	i64 17031351772568316411, ; 319: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 76
	i64 17062143951396181894, ; 320: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 99
	i64 17089008752050867324, ; 321: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 32
	i64 17118171214553292978, ; 322: System.Threading.Channels => 0xed8ff6060fc420b2 => 161
	i64 17201328579425343169, ; 323: System.ComponentModel.EventBasedAsync => 0xeeb76534d96c16c1 => 98
	i64 17202182880784296190, ; 324: System.Security.Cryptography.Encoding.dll => 0xeeba6e30627428fe => 150
	i64 17230721278011714856, ; 325: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 130
	i64 17234219099804750107, ; 326: System.Transactions.Local.dll => 0xef2c3ef5e11d511b => 165
	i64 17260702271250283638, ; 327: System.Data.Common => 0xef8a5543bba6bc76 => 103
	i64 17310272924926077006, ; 328: FeelingsApp.dll => 0xf03a7182ef47e84e => 91
	i64 17342750010158924305, ; 329: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 10
	i64 17360349973592121190, ; 330: Xamarin.Google.Crypto.Tink.Android => 0xf0ec5a52686b9f66 => 87
	i64 17438153253682247751, ; 331: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 25
	i64 17514990004910432069, ; 332: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 8
	i64 17553799493972570483, ; 333: Google.Protobuf.dll => 0xf39b9fa2c0aab173 => 36
	i64 17623389608345532001, ; 334: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 20
	i64 17702523067201099846, ; 335: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 31
	i64 17704177640604968747, ; 336: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 75
	i64 17710060891934109755, ; 337: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 73
	i64 17712670374920797664, ; 338: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 139
	i64 17777860260071588075, ; 339: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 142
	i64 17979120673405951447, ; 340: ZstdSharp => 0xf982aafeb83e5dd7 => 90
	i64 18025913125965088385, ; 341: System.Threading => 0xfa28e87b91334681 => 164
	i64 18099568558057551825, ; 342: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 19
	i64 18121036031235206392, ; 343: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 76
	i64 18146411883821974900, ; 344: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 109
	i64 18146811631844267958, ; 345: System.ComponentModel.EventBasedAsync.dll => 0xfbd66d08820117b6 => 98
	i64 18225059387460068507, ; 346: System.Threading.ThreadPool.dll => 0xfcec6af3cff4a49b => 163
	i64 18245806341561545090, ; 347: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 94
	i64 18305135509493619199, ; 348: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 78
	i64 18324163916253801303 ; 349: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 14
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [350 x i32] [
	i32 47, ; 0
	i32 174, ; 1
	i32 51, ; 2
	i32 113, ; 3
	i32 64, ; 4
	i32 81, ; 5
	i32 82, ; 6
	i32 90, ; 7
	i32 7, ; 8
	i32 134, ; 9
	i32 53, ; 10
	i32 56, ; 11
	i32 162, ; 12
	i32 101, ; 13
	i32 10, ; 14
	i32 69, ; 15
	i32 134, ; 16
	i32 86, ; 17
	i32 18, ; 18
	i32 108, ; 19
	i32 77, ; 20
	i32 120, ; 21
	i32 48, ; 22
	i32 173, ; 23
	i32 162, ; 24
	i32 16, ; 25
	i32 62, ; 26
	i32 74, ; 27
	i32 54, ; 28
	i32 115, ; 29
	i32 129, ; 30
	i32 36, ; 31
	i32 61, ; 32
	i32 138, ; 33
	i32 6, ; 34
	i32 81, ; 35
	i32 107, ; 36
	i32 28, ; 37
	i32 82, ; 38
	i32 49, ; 39
	i32 28, ; 40
	i32 148, ; 41
	i32 73, ; 42
	i32 2, ; 43
	i32 20, ; 44
	i32 107, ; 45
	i32 54, ; 46
	i32 69, ; 47
	i32 94, ; 48
	i32 24, ; 49
	i32 112, ; 50
	i32 72, ; 51
	i32 158, ; 52
	i32 136, ; 53
	i32 65, ; 54
	i32 145, ; 55
	i32 60, ; 56
	i32 27, ; 57
	i32 118, ; 58
	i32 42, ; 59
	i32 2, ; 60
	i32 136, ; 61
	i32 146, ; 62
	i32 55, ; 63
	i32 7, ; 64
	i32 86, ; 65
	i32 149, ; 66
	i32 155, ; 67
	i32 71, ; 68
	i32 127, ; 69
	i32 142, ; 70
	i32 124, ; 71
	i32 89, ; 72
	i32 51, ; 73
	i32 40, ; 74
	i32 83, ; 75
	i32 171, ; 76
	i32 22, ; 77
	i32 145, ; 78
	i32 41, ; 79
	i32 167, ; 80
	i32 40, ; 81
	i32 170, ; 82
	i32 80, ; 83
	i32 44, ; 84
	i32 49, ; 85
	i32 150, ; 86
	i32 121, ; 87
	i32 115, ; 88
	i32 144, ; 89
	i32 131, ; 90
	i32 33, ; 91
	i32 101, ; 92
	i32 163, ; 93
	i32 147, ; 94
	i32 113, ; 95
	i32 100, ; 96
	i32 30, ; 97
	i32 0, ; 98
	i32 60, ; 99
	i32 83, ; 100
	i32 108, ; 101
	i32 118, ; 102
	i32 141, ; 103
	i32 53, ; 104
	i32 135, ; 105
	i32 135, ; 106
	i32 96, ; 107
	i32 96, ; 108
	i32 155, ; 109
	i32 125, ; 110
	i32 141, ; 111
	i32 138, ; 112
	i32 26, ; 113
	i32 59, ; 114
	i32 29, ; 115
	i32 110, ; 116
	i32 153, ; 117
	i32 148, ; 118
	i32 85, ; 119
	i32 37, ; 120
	i32 109, ; 121
	i32 151, ; 122
	i32 23, ; 123
	i32 23, ; 124
	i32 159, ; 125
	i32 165, ; 126
	i32 132, ; 127
	i32 34, ; 128
	i32 72, ; 129
	i32 11, ; 130
	i32 68, ; 131
	i32 46, ; 132
	i32 156, ; 133
	i32 19, ; 134
	i32 22, ; 135
	i32 106, ; 136
	i32 168, ; 137
	i32 166, ; 138
	i32 127, ; 139
	i32 130, ; 140
	i32 112, ; 141
	i32 26, ; 142
	i32 114, ; 143
	i32 93, ; 144
	i32 100, ; 145
	i32 39, ; 146
	i32 166, ; 147
	i32 128, ; 148
	i32 105, ; 149
	i32 117, ; 150
	i32 17, ; 151
	i32 171, ; 152
	i32 92, ; 153
	i32 88, ; 154
	i32 62, ; 155
	i32 140, ; 156
	i32 97, ; 157
	i32 71, ; 158
	i32 116, ; 159
	i32 104, ; 160
	i32 172, ; 161
	i32 97, ; 162
	i32 52, ; 163
	i32 105, ; 164
	i32 137, ; 165
	i32 153, ; 166
	i32 79, ; 167
	i32 133, ; 168
	i32 58, ; 169
	i32 129, ; 170
	i32 21, ; 171
	i32 172, ; 172
	i32 92, ; 173
	i32 78, ; 174
	i32 21, ; 175
	i32 104, ; 176
	i32 168, ; 177
	i32 31, ; 178
	i32 149, ; 179
	i32 35, ; 180
	i32 85, ; 181
	i32 61, ; 182
	i32 87, ; 183
	i32 160, ; 184
	i32 65, ; 185
	i32 95, ; 186
	i32 174, ; 187
	i32 50, ; 188
	i32 6, ; 189
	i32 39, ; 190
	i32 117, ; 191
	i32 131, ; 192
	i32 48, ; 193
	i32 3, ; 194
	i32 68, ; 195
	i32 123, ; 196
	i32 133, ; 197
	i32 132, ; 198
	i32 89, ; 199
	i32 66, ; 200
	i32 1, ; 201
	i32 93, ; 202
	i32 137, ; 203
	i32 120, ; 204
	i32 38, ; 205
	i32 45, ; 206
	i32 50, ; 207
	i32 12, ; 208
	i32 84, ; 209
	i32 15, ; 210
	i32 46, ; 211
	i32 67, ; 212
	i32 55, ; 213
	i32 139, ; 214
	i32 57, ; 215
	i32 13, ; 216
	i32 84, ; 217
	i32 44, ; 218
	i32 170, ; 219
	i32 9, ; 220
	i32 123, ; 221
	i32 159, ; 222
	i32 144, ; 223
	i32 57, ; 224
	i32 70, ; 225
	i32 75, ; 226
	i32 34, ; 227
	i32 106, ; 228
	i32 63, ; 229
	i32 111, ; 230
	i32 14, ; 231
	i32 64, ; 232
	i32 157, ; 233
	i32 27, ; 234
	i32 47, ; 235
	i32 126, ; 236
	i32 56, ; 237
	i32 91, ; 238
	i32 143, ; 239
	i32 58, ; 240
	i32 1, ; 241
	i32 15, ; 242
	i32 173, ; 243
	i32 9, ; 244
	i32 125, ; 245
	i32 88, ; 246
	i32 29, ; 247
	i32 30, ; 248
	i32 13, ; 249
	i32 80, ; 250
	i32 146, ; 251
	i32 99, ; 252
	i32 8, ; 253
	i32 11, ; 254
	i32 102, ; 255
	i32 59, ; 256
	i32 70, ; 257
	i32 3, ; 258
	i32 63, ; 259
	i32 164, ; 260
	i32 157, ; 261
	i32 152, ; 262
	i32 121, ; 263
	i32 24, ; 264
	i32 5, ; 265
	i32 158, ; 266
	i32 151, ; 267
	i32 143, ; 268
	i32 42, ; 269
	i32 16, ; 270
	i32 32, ; 271
	i32 147, ; 272
	i32 67, ; 273
	i32 33, ; 274
	i32 0, ; 275
	i32 154, ; 276
	i32 156, ; 277
	i32 43, ; 278
	i32 126, ; 279
	i32 111, ; 280
	i32 122, ; 281
	i32 116, ; 282
	i32 128, ; 283
	i32 17, ; 284
	i32 110, ; 285
	i32 114, ; 286
	i32 41, ; 287
	i32 66, ; 288
	i32 43, ; 289
	i32 102, ; 290
	i32 4, ; 291
	i32 152, ; 292
	i32 124, ; 293
	i32 74, ; 294
	i32 169, ; 295
	i32 35, ; 296
	i32 167, ; 297
	i32 4, ; 298
	i32 12, ; 299
	i32 5, ; 300
	i32 161, ; 301
	i32 119, ; 302
	i32 169, ; 303
	i32 122, ; 304
	i32 18, ; 305
	i32 45, ; 306
	i32 154, ; 307
	i32 119, ; 308
	i32 37, ; 309
	i32 52, ; 310
	i32 79, ; 311
	i32 140, ; 312
	i32 103, ; 313
	i32 38, ; 314
	i32 160, ; 315
	i32 25, ; 316
	i32 77, ; 317
	i32 95, ; 318
	i32 76, ; 319
	i32 99, ; 320
	i32 32, ; 321
	i32 161, ; 322
	i32 98, ; 323
	i32 150, ; 324
	i32 130, ; 325
	i32 165, ; 326
	i32 103, ; 327
	i32 91, ; 328
	i32 10, ; 329
	i32 87, ; 330
	i32 25, ; 331
	i32 8, ; 332
	i32 36, ; 333
	i32 20, ; 334
	i32 31, ; 335
	i32 75, ; 336
	i32 73, ; 337
	i32 139, ; 338
	i32 142, ; 339
	i32 90, ; 340
	i32 164, ; 341
	i32 19, ; 342
	i32 76, ; 343
	i32 109, ; 344
	i32 98, ; 345
	i32 163, ; 346
	i32 94, ; 347
	i32 78, ; 348
	i32 14 ; 349
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.2xx @ 0d97e20b84d8e87c3502469ee395805907905fe3"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
