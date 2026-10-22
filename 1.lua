-- BRPlayerCharacterBase - Full features + MAGIC BULLET + GRAPHICS BYPASS + FIKTUR+ + MB/AIM/REPORT/WH/SECURITY PROTECTION
local ENetRole = import("ENetRole")
local EPawnState = import("EPawnState")
local GameplayData = require("GameLua.GameCore.Data.GameplayData")
local KismetMathLibrary = import("KismetMathLibrary")
local GameplayStatics = import("GameplayStatics")
local InGameMarkTools = require("GameLua.Mod.BaseMod.Common.InGameMarkTools")
local GamePlayTools = require("GameLua.Mod.BaseMod.Common.GamePlayTools")

-- Online license verification replaces offline expiry.
-- Mods are locked until _G.IsLicenseOK() returns true.
_G._MOD_EXPIRED = true

_G.AK_Features = {
    { id = "ESP_HP",    name = "ESP Health Bar", val = 1, type = "toggle" },
    { id = "ESP_BOX",   name = "ESP Box",        val = 0, type = "toggle" },
    { id = "ESP_MAP",   name = "Mini Map ESP",   val = 0, type = "toggle" },
    { id = "WALLHACK",  name = "Wallhack",       val = 0, type = "toggle" },
    { id = "REDBOX_COUNT", name = "RedBox Enemy Counter", val = 1, type = "toggle" },
    { id = "SNAPLINE",  name = "Snap Line to Enemy Head", val = 0, type = "toggle" },
    { id = "AIMBOT",    name = "Aimbot",         val = 0, type = "toggle" },
    { id = "IPAD_VIEW", name = "iPad View",      val = 0, type = "toggle" },
    { id = "AUTO_MASS_REPORT", name = "Auto Report All Maps", val = 0, type = "toggle" },
    { id = "AUTO_REPORT_KILL", name = "Auto Report Killer", val = 0, type = "toggle" },
    { id = "TEST_FEEDBACK", name = "Test Feedback",  val = 0, type = "toggle" },
    { id = "BLACK_SKY",   name = "Black Sky",       val = 0, type = "toggle" },
    { id = "NO_FOG",      name = "Remove Fog",      val = 0, type = "toggle" },
    { id = "UNLOCK_FPS",  name = "Unlock 165 FPS",  val = 0, type = "toggle" },
}

function _G.AK_GetVal(featureId)
    for _, feature in ipairs(_G.AK_Features) do
        if feature.id == featureId then return feature.val end
    end
    return 0
end

function _G.AK_SetVal(featureId, value)
    for _, feature in ipairs(_G.AK_Features) do
        if feature.id == featureId then
            feature.val = value
            return
        end
    end
end

-- =======================@RAHMANYVI======================
-- =======================@RAHMANYVI======================
-- =======================@RAHMANYVI======================
local BlockedSecurityModules = {
  "Server.security.GameSafeCallbacks",
  "Server.security.AllStrategyCfgLines",
  "Server.security.PlayerSafeCallback",
  "Server.security.WeaponSafeCallback",
  "Server.security.VehicleSafeCallback",
  "Server.security.ESPSafeCallback",
  "Server.security.IntegrityCheckCallback",
  "Server.security.AndroidObscuredCallback",
  "Server.security.SecurityCommon",
  "Server.security.TickEncryptCallback",
  "Server.security.MoveInputCallback",
  "Server.security.AutoAimConfig",
  "Server.security.PeekShootVerifyCallback",
  "Server.security.SecurityPakCallback",
  "Server.security.BaziConfig",
  "Server.security.AvatarCheckCallback",
}

for _, modulePath in ipairs(BlockedSecurityModules) do
  package.loaded[modulePath] = {}
end

-- =======================@RAHMANYVI=======================
-- =======================@RAHMANYVI=======================
local USTExtraBlueprintFunctionLibrary = import("STExtraBlueprintFunctionLibrary")
local SecurityCommonUtils = require("GameLua.Mod.BaseMod.Common.Security.SecurityCommonUtils")
local IsNumber = SecurityCommonUtils.IsNumber
local IsString = SecurityCommonUtils.IsString
local IsNonemptyString = SecurityCommonUtils.IsNonemptyString
local FormatLog = FuncUtil.FormatLog
local bIsDevelopment = false
local bIsRelease = true

-- =======================@RAHMANYVI=======================
-- 🔥 PART 3: GLOBAL TABLES
-- =======================@RAHMANYVI=======================
_G.GameSafeCallbacks = _G.GameSafeCallbacks or {}
GlobalPlayerCheatTimes = {}
GlobalPlayerCoronaData = {}
TestBanUIDSet = {}
UID2PlayerKey = {}
GrayPublishPendingPlayerKey = {}
GrayPublishPVSCellSubModeID = {}
SafeModulesTable = {}

-- =======================@RAHMANYVI=======================
-- 🔥 PART 4: ENUM PLACEHOLDERS (fully defined)
-- =======================@RAHMANYVI=======================
ScriptReportEnum = {
  ObscuredData = "",
  Kills = 0,
  ClientInfo = "",
  DiffRuntimeMatched = 0,
  Level = 0,
  ClientGravityAnomalyCount = 0,
  ShootVerifyClientHitAABBCount = 0,
  ShootVerifyDSAABBMissCount = 0,
  WeaponScopeHeightBigNum = 0,
  WeaponScopeDisBigNum = 0,
  OwnerHeadAndMuzzleBlockNum = 0,
  ImpactPointAndBulletDisBigNum = 0,
  ShootVerifyInvalidNum = 0,
  BulletDirError = 0,
  ClientAccFrame = 0,
  EspData = "",
  ClientGravityZ = -980,
  HeartBreaks = 0,
  MaxFlySkyTime = 0,
  StartFlySkyTime = 0,
  FlySkyTimes = 0,
  IsDynamicActorsEnabled = 0,
  DynamicActorsData = "",
  IntegrityCheckNotMatchCount = 0,
  IntegrityCheckNotMatchDetail = "",
  BulletFireSpeed = 0,
  ClientScreenShot = 0,
  FlyingErrorCnt = 0,
  MaxFlyingDuration = 0,
  FlyingStableRate = 0,
  PlayerPingRecordArray = {},
  PlayerPingReportCount = 0,
  PlayerPingReport = "",
  PlayerBadPingTimes = 0,
  PlayerReportedCount = 0,
  MinUndilatedFrameTime = 0,
  AccumulatedFightingStateTime = 0,
  PVSInCityKillTotalTime = 0,
  PVSNotInCityKillTotalTime = 0,
  PVSInCityKillerTotalMoveDistance = 0,
  PVSNotInCityKillerTotalMoveDistance = 0,
  IsTickEncryptEnabled = 0,
  TickEncryptDetail = "",
  ShooterCapsuleCollided = 0,
  AvatarCheckData = "",
  JumpMaxCount = 0,
  pubgmvStr62 = 0,
  pubgmvStr63 = 0,
  IsPeekShootVerifyEnabled = 0,
  PeekShootVerifyDetail = "",
  InvalidPakFiles = "",
  IsMoveInputEnabled = 0,
  pubgmvStr67 = 0,
  pubgmvStr68 = 0,
  TeamID = 0,
  BlackAvatarCount = 0,
}
ScriptReportIndex = {
  ObscuredData = 1, PlayerPingReport = 2, ClientInfo = 3,
  PlayerBadPingTimes = 4, Level = 5, PlayerReportedCount = 6,
  PVSInCityKillTotalTime = 7, AccumulatedFightingStateTime = 8,
  Kills = 9, ClientGravityAnomalyCount = 10,
  ShootVerifyClientHitAABBCount = 11, ShootVerifyDSAABBMissCount = 12,
  BulletDirError = 13, FlyingStableRate = 14, EspData = 15,
  ClientGravityZ = 16, HeartBreaks = 17, ClientAccFrame = 18,
  MaxFlyingDuration = 19, FlyingErrorCnt = 20,
  StartFlySkyTime = 21, MaxFlySkyTime = 22, FlySkyTimes = 23,
  IsDynamicActorsEnabled = 24, DynamicActorsData = 25,
  IntegrityCheckNotMatchCount = 26, IntegrityCheckNotMatchDetail = 27,
  BulletFireSpeed = 28, WeaponScopeHeightBigNum = 29,
  WeaponScopeDisBigNum = 30, OwnerHeadAndMuzzleBlockNum = 31,
  ClientScreenShot = 32, ImpactPointAndBulletDisBigNum = 33,
  ShootVerifyInvalidNum = 34, DiffRuntimeMatched = 35,
  IsTickEncryptEnabled = 36, TickEncryptDetail = 37,
  JumpMaxCount = 38, pubgmvStr55 = 39,
  PVSInCityKillerTotalMoveDistance = 40,
  PVSNotInCityKillerTotalMoveDistance = 41,
  PVSNotInCityKillTotalTime = 42, MinUndilatedFrameTime = 43,
  ShooterCapsuleCollided = 44, AvatarCheckData = 45,
  pubgmvStr62 = 46, pubgmvStr63 = 47,
  IsPeekShootVerifyEnabled = 48, PeekShootVerifyDetail = 49,
  IsMoveInputEnabled = 50, InvalidPakFiles = 51,
  pubgmvStr68 = 52, TeamID = 53, BlackAvatarCount = 54,
}
local ScriptReportIndexCount = 54
ScriptReportEnum.__index = ScriptReportEnum

-- =======================@RAHMANYVI=======================
-- 🔥 PART 5: FULL CoronaDataEnum (all 200+ fields)
-- =======================@RAHMANYVI=======================
CoronaDataEnum = {
  TotalStatisticCnt = 0, CrcCheckRet = 0, bAndroid = 0, bRoot = 0,
  bSimulator = 0, bHasMalware = 0, bTssMgrDie = 0, TssFeatureState = 0,
  Level = 0, ReportedCount = 0, IOSAppSignFailedCnt = 0, AOSAppSignFailedCnt = 0,
  LibCheckFailedCnt = 0, GrassDensityFailedCnt = 0, AnubisResFailedCnt = 0,
  AnubisCrc = 0, ChronosResFailedCnt = 0, ChronosVer = 0,
  ArtemisResFailedCnt = 0, ArtemisCrc = 0, DianaResFailedCnt = 0,
  DianaCrc = 0, AppSignCrc = 0, SoCheckFailedCnt = 0, BasePakFailedCnt = 0,
  CheckFilesInPakFailedCnt = 0, EnemyBoneMaxLen = 0, EnemyBoneFailedCnt = 0,
  EnemyPhyAggemFailedCnt = 0, MaxWalkSpeed = 0, WalkSpeedFailedCnt = 0,
  SelfModelFailedCnt = 0, EspTotalTime = 0, EspTotalCnt = 0,
  AutoAimTotalCnt = 0, AutoRotationTotalCnt = 0, AutoCameraRotationTotalCnt = 0,
  AutoCameraLocationTotalCnt = 0, AutoAimByLockViewPitchTotalCnt = 0,
  AutoAimByLockViewYawTotalCnt = 0, MarcoPoloYawChangedCount = 0,
  MarcoPoloVerifyFailedCount = 0, MarcoPoloWorldYawChangedCount = 0,
  RocoilLessTotalCnt = 0, WeaponIDList = "", DistOfScope2Head = 0,
  DistOfScope2HeadFailedCnt = 0, AutoAimCfgFailedCnt = 0, RecoilCfgFailedCnt = 0,
  DeviationCfgFailedCnt = 0, AccessoryFactorFailedCnt = 0,
  RecoilCurveFailedCnt = 0, AimInputFailedCnt = 0, BulletDirFailedCnt = 0,
  BulletDirDSErrorCnt = 0, AimCompInputFailedCnt1 = 0, AimCompInputFailedCnt2 = 0,
  AimCompInputFailedCnt3 = 0, AimCompInputFailedCnt4 = 0,
  NormalShootTotalKillCnt100 = 0, NormalShootKillCnt30 = 0,
  NormalShootKillLockHeadCnt30 = 0, OpenScopeShootKillCnt100 = 0,
  OpenScopeShootKillLockHeadCnt100 = 0, IntegrityCheckNotMatchCount = 0,
  TotalOutOfOrderPackets = 0, MaxOutOfOrderPacketsPerSec = 0,
  ProofRawData = "", EspBattleInvisibleCnt = 0, EspOpenScopeInvisibleCnt = 0,
  EspContinueInvisibleCnt = 0, DSSpeedOver10FailedCnt = 0,
  DSSpeedOver15FailedCnt = 0, DSSpeedOver20FailedCnt = 0, ClientAccFrame = 0,
  JumpMaxHeight2 = 0, DSPlayerZ = 0, SelfBoneLenOverMaxFailedCnt = 0,
  TotalSkeletonLengthMax = 0, SkeletonLengthCheckInvaildNum = 0,
  TimeAccTotal = 0, SpeedQuickCheck = 0, FlyCar2 = 0,
  MuzzleAndOwnerPosInVaildNum = 0, MuzzleAndHeadPassWall = 0,
  ShootVerifyClientHitAABBCount = 0, ShootVerifyDSAABBMissCount = 0,
  MissRate = 0, PrisonBreaks = 0, PlayerBadPingTimes = 0,
  ServerAccumulateErrors = 0, ServerAvgErrors = 0,
  AndroidOrSimRootCnt = 0, IOSRootCnt = 0, KillNum = 0,
  nHawkEyeSpectatorVerifyFailedCount = 0, FlySkyTimes = 0,
  EspTotalSimTraceCnt = 0, EspTotalImeFocusCnt = 0, TimeOut10Kill = 0,
  MuzzleImpactDirError2 = 0, ShootPosHistoryLocusError2 = 0,
  MuzzleLocusError = 0, MuzzleLocusErrorX = 0, MuzzleLocusErrorY = 0,
  MuzzleLocusErrorZ = 0, FlyingErrorCnt = 0, MaxFlyingDuration = 0,
  FlyingStableRate = 0, IllegalTeamUpNearbyButNoFireAfterKill = 0,
  IllegalTeamUpNearbyButNoFirePickUpItem = 0, IllegalTeamUpNearbyButNoFireNotKill = 0,
  IllegalTeamUpNearbyButNoFireOnVehicle = 0, IllegalTeamUpNearbyButNoFireSameVehicle = 0,
  IllegalTeamUpUseObjectTogether = 0, IllegalTeamUpStayOnEnemyVehicle = 0,
  IllegalTeamUpGetOnEnemyVehicleCount = 0,
  IllegalTeamUpNearbyButNoFireOneSideHasWeaponOnFoot = 0,
  BulletFireSpeed = 0, ClientGravityAnomalyCount = 0,
  BulletFlySpeedIncreaseCount = 0, ShootBirdNonGunADS = 0,
  NonGunADSFarShootFromClientBulletDataCount = 0,
  MinUndilatedFrameTimeFailedCount = 0, DSFallingSpeedFailCount = 0,
  DSFallingHeightFailCount = 0, ShootInterval = 1.0E8,
  ExtraHitPerformScale = -1, SwitchWeaponSpeedScale = -1,
  AnimationKick = 1.0E8, RecoilKickADS = 1.0E8,
  AccessoriesVRecoilFactor = 1.0E8, AccessoriesHRecoilFactor = 1.0E8,
  AccessoriesRecoveryFactor = 1.0E8, PVSInCityKillCount = 0,
  PVSNotInCityKillCount = 0, AccumulatedFightingStateTime = 0,
  ShooterCapsuleCollided = 0, LargeRotateLockShooting = 0,
  SmallRotateLockShooting = 0, OneClipShootCount = 0,
  ClientWeaponFastReload = 0, ActorTimeDilationFailCount = 0,
  FarJumpTimes = 0, JumpMaxHeight = 0, SmallActorTimeDilationCount = 0,
  JumpZVelocity = -1, PeekShootRotationModifiedCount = 0,
  PeekShootTranslationModifiedCount = 0, PeekShootScale3DModifiedCount = 0,
  pubgmcdvStr61 = "", pubgmcdvStr62 = "", pubgmcdvStr63 = "",
  pubgmcdvStr64 = "", pubgmcdvStr65 = "", pubgmcdvStr66 = "",
  MaxMoveDistance2DPerSecond = "", NonGunADSFarShootCount = "",
  pubgmcdvStr69 = "", pubgmcdvStr70 = "", ClientTimeSpeedAcc = 0,
  ClientTimeTotalAcc = 0, JumpMaxCount = 0, TimeDilation = -1,
  KillOtherAfterBurstMove = 0, MaxAcceleration = -1,
  ClientTimestampBurst = 0, DSCheckClientTimeMoveDistance2D = 0,
  IsServerControlMove = 0, ServerMoveCorrectsPerSecond = 0,
  ClientTimeReset = 0, ClientGlueHiaSystemTickAnomaly = 0,
  ParachuteLandingSecondsExceedThreshold = 0,
  ParachuteObliqueLandingSecondsExceedThreshold = 0,
  IntervalFrequencyStatisticsMax = 0, IntervalFrequencyStatisticsAverage = 0,
  VehicleMoveDirection = 0, VehicleSidesway1 = 0, VehicleSidesway2 = 0,
  BurstPickup = 0, GetOnEnemyVehicleID = -1, StayOnEnemyVehicleID = -1,
  BlackAvatarCount = 0,
}
-- Add ClientAutoAimConfig001-050
for i = 1, 50 do
  CoronaDataEnum[string.format("ClientAutoAimConfig%03d", i)] = 0
end
CoronaDataEnum.__index = CoronaDataEnum

-- =======================@RAHMANYVI=======================
-- 🔥 PART 6: OTHER ENUMS
-- =======================@RAHMANYVI=======================
ECoronaProofType = {
  ECoronaProofNone = 0, ECoronaProofSoFile = 1, ECoronaProofBone = 2,
  ECoronaProofCVar = 3, ECoronaProofMax = 4
}
ECoronaDataType = {
  ECoronaDataNone = 0, ECoronaDataPlayer = 1, ECoronaDataVehicle = 2,
  ECoronaDataWeapon = 3, ECoronaDataRes = 4, ECoronaDataDevice = 5,
  ECoronaDataOthers = 6, ECoronaDataCVar = 7,
  ECoronaClientLuaHotUpdateData = 8, ECoronaDataMax = 9
}
EHawkFamily = {
  Blind = 0, BlindAll = 1, Heart = 2, ClientVersion = 3,
  DynamicActors = 4, SwitchAck = 5, CClientInfoPacket = 6,
  SIntegrityItemCheckPacket = 7, CIntegrityItemCheckResultPacket = 8,
  SIntegrityMemoryReadPacket = 9, CIntegrityMemoryReadResultPacket = 10,
  ClientScreenShot = 11, SControlAndroidObscuredPacket = 12,
  CObscuredStatusPacket = 13, CDeviceInfoPacket = 14, CVarDownList = 15,
  EnhancedDynamicActors = 16, SAvatarCheckControlPacket = 20,
  CAvatarCheckDataPacket = 21, SMoveInputRecordControlPacket = 22,
  CMoveInputRecordPacket = 23, SEnablePeekShootVerify = 24,
  CPeekShootVerifyResult = 25, HeartAck = 26, SEnableCheckPakFiles = 27,
  CCheckFilesInPakFailed = 28
}
EStrategyOperatorType = { Greater = 0, Less = 1 }
EClientDataPointerValueType = { Bool = 1, Int32 = 2, Float = 3 }
EGrayPublishType = { PVSCell = 7, SpeedQuickCheck = 25 }
GrayPublishProbabilityConfig = {}

-- =======================@RAHMANYVI=======================
-- 🔥 PART 7: FULL AOSCheatSoTable (200+ names)
-- =======================@RAHMANYVI=======================
AOSCheatSoTable = {
  "libAliSalimMod", "libDangerpro", "libMyLibName", "libSoiShipperGLOBAL",
  "libskpkg", "libamunmods", "libSoiShipperVNG", "libGrimReapers",
  "libHMODEVIP", "libPutriMod", "libalamdar", "libSYRI", "libABNS",
  "libhma_native_hooks", "libNTTGAMING", "libteamUxH", "libAPK_CRACKING_ZONE",
  "libFakecez", "libRUDRA", "libKINGCHAET", "libsgr", "libMyLib", "libmiku",
  "libPanda", "libRaunakMods", "libepic64", "libexp82464", "libmodxpro",
  "libSPARTAGAMINGS", "libSasuke", "libRicMods", "libCMODS", "libmodxproESP",
  "libSACRMOD", "libSoiShipperChannel", "libSameerArora", "libFuCkYou",
  "libMAAN", "libCHEAT", "libKING", "libNicOP", "libepic", "libexp824",
  "libndk", "libDanger", "libHentai", "libMpMods", "libHackerWorldMods",
  "SameerArora", "libteamdymond", "libpubgm", "libsuria", "libSY",
  "libabnsyr", "libsyr", "libABN_SYRIA", "libsrc", "libABN",
  "libBlackNinjaMod", "libRubel", "libEpic", "libArmEpic", "libRSDMODS",
  "libGaribGamingEsp", "libfuck", "libRGMESP", "libKINGCHEAT", "libNicHacks",
  "libAutoChickens", "libarm", "libZzZ", "libNirobAhammed", "libsagar",
  "libBangjo", "libruruzi", "PUBGMESP7", "libZzz", "SORS DIV IOS",
  "libsaolei", "libFPCMOD", "FLAME", "libGKPMODS", "libhacks", "libRURUZI",
  "libHackerBody", "libsurprisecheats", "libtersafe", "libbypass",
  "libanogs_lx.so", "liblive.so", "libmib.so", "libNASA", "libboss",
  "libGKPxStudio", "libtdfix", "libfix", "libCrashFix", "libYZYMOD",
  "libanort_jni", "libtdmodgame", "libpaCQMOD8", "libXZNB", "libZeroFix",
  "libzZzz", "SFLAME", "libSPEED", "libHunter", "DrawHM", "Alamofire",
  "libarisu", "libsigplus", "libmiwumod", "libmatrix", "libSpider",
  "libGKPCRASHFIX64", "libaa", "libTITAN", "libSanseroFixCrash",
  "libavaritia", "libbantai", "libsCQMOD", "fuckreports", "libFYISULTAN",
  "libpawpaw", "libFAN1", "libApples", "libFix", "libUE4Game",
  "libSignatureKiller", "libkiller", "libkDogProNew", "libtDogProNew",
  "libfoza", "liblsplant", "libreverse", "libshieldplus", "libtoolChecker",
  "libUSA", "libarm_classes", "libhDCGZS37", "libhDCGZS39", "libiDCGZS90",
  "libtDCGZS46", "lib4399", "libzx", "libtdmod", "libShrem", "libVIP",
  "libPUBGM", "libAkshatModz", "libFox", "libss", "libMSDS9", "libSTRONG",
  "libYM", "libSpider1", "libcc", "libApple", "libQX", "libGOST", "libMTR1",
  "libMKmod", "libVIP1", "libYTsine", "libPutrimod", "libJSZMOD", "libXuan",
  "libCRASHFix", "libCK", "libdttsxa", "libFLAME", "libXERO", "libJL",
  "libVenus", "libCKYMOD", "libccc", "libFOXFS", "libHTD", "libHY",
  "libViper", "libHASADXSA", "libXINMODD", "libpl_droidsonroids_gif",
  "Blackshark", "libHarley", "libXH", "libhxd", "libHOOK", "libBangjo1",
  "libOffWork", "libErickk", "libMarcusMod", "libzDogPro", "libzDogProNew",
  "libXinmod", "libXinmodd", "libGodCheat", "libBOZZ", "libHHx", "libxiuke",
  "libbrk", "libQuangAre22", "libgoo", "libAlex", "libHarleyCheat",
  "libALOUSH", "libHASADV8KG", "libexe_right", "libubaydulla", "libTheo",
  "libNHKMOD", "libmono", "libWH", "libAZ997926", "libUZIMOD", "libAli",
  "libZERO", "libkeysuperman", "libtool", "libNIKE", "libx", "libNG",
  "libav2d", "libjo", "libxcheeat", "libhaoyunb", "libPubgm", "libWuGan",
  "libSTRESS_CHEAT", "libjcnb", "libUbaydulla", "libRC", "libRCFIX",
  "libfenghuang", "libmundo", "libELMOD", "libKK", "libQZUIM", "libav3d",
  "libwl", "libWQ", "libVENOM", "libQYGM", "libKawKab", "libHASADV10X",
  "lib10xulaconcho", "libGAMAL", "libTakeo",
}
--@ RAHMANYVI 
-- =======================@RAHMANYVI=======================
-- 🔥 PART 8: OTHER CONFIG TABLES
-- =======================@RAHMANYVI=======================
tBalticModeIDSet = {
  [1001] = false, [1002] = false, [1003] = false,
  [2001] = false, [2002] = false, [2003] = false,
  [1064] = false, [1065] = false, [1066] = false,
  [2064] = false, [2065] = false, [2066] = false,
  [60112] = false, [60113] = false, [60114] = false,
  [60115] = false, [60116] = false, [60117] = false,
  [64200] = false, [64201] = false, [64202] = false,
  [64203] = false, [64204] = false, [64205] = false,
}

BattleReportNosChatOnlyOnceStrategySet = { [87510] = false }
BattleReportNosChatOnlyOnceStrategyHistory = {}
IgnoreBulletFireSpeedWeaponID = { [108030] = false }
SkipStrategyIDofReportBanPlayer = { [87520] = false }

CompositeStrategyBanLessDimensionAlertWhiteList = {
  CrcCheckRet = false, bAndroid = false, bRoot = false, bSimulator = false,
  bHasMalware = false, Level = false, ReportedCount = false,
  TotalOutOfOrderPackets = false, MaxOutOfOrderPacketsPerSec = false,
  ProofRawData = false, PlayerBadPingTimes = false,
  AndroidOrSimRootCnt = false, IOSRootCnt = false, KillNum = false,
}

CompositeStrategySingleDimensionSkipAlertLessThan = { BulletFireSpeed = false }

CompositeStrategySingleDimensionSkipAlert = {
  TotalStatisticCnt = false, JumpMaxHeight = false, JumpMaxHeight2 = false,
  AccumulatedFightingStateTime = false, EspOpenScopeInvisibleCnt = false,
  LibCheckFailedCnt = false, IsServerControlMove = false,
  MaxAcceleration = false, NonGunADSFarFromClientBulletDataCount = false,
  RocoilLessTotalCnt = false,
}

-- =======================@RAHMANYVI=======================
-- 🔥 PART 9: HELPER FUNCTIONS (no-op)
-- =======================@RAHMANYVI=======================
function DSDeepCopyTable(object)
  return {}
end

function ValuClamp(t, min, max)
  return t
end

local function ConvertByteCodeStringToArray(sLuaHexString)
  return {}
end

local function GetPlayerTable(bIsDatabase, nUID)
  return nil
end

local function SetPlayerTableField(bIsDatabase, nUID, sName, Value)
end

local function GetPlayerTableField(bIsDatabase, nUID, sName)
  return nil
end

local function IncreasePlayerTableField(bIsDatabase, nUID, sName, nValue)
end

local function MonotonicSetPlayerTableField(bIsDatabase, nUID, sName, nValue, bIsIncrease)
end

local function GetDSGlueHiaSystem()
  return nil
end

local function GetClientDataPointerValue(DataPointer, Type, Name)
  return nil
end

local function SetVerifySwitchField(Controller, SwitchName, FieldName, NewValue)
end

local function IncreaseCheckBanFailCount(OperatorType, CurValue, ThresholdValue, FailedCnt)
  return FailedCnt
end

-- =======================@RAHMANYVI=======================
-- 🔥 PART 10: ALL GameSafeCallbacks FUNCTIONS = NO-OP
-- =======================@RAHMANYVI=======================
function GameSafeCallbacks.GetGrayPublishProbability(Type) return -1 end
function GameSafeCallbacks.IsGrayPublish(Type) return false end
function GameSafeCallbacks.DSPatchLua(a, b) print("[MASTER-BYPASS] DSPatchLua - BLOCKED") end
function GameSafeCallbacks.LoadSafePatchModules() print("[MASTER-BYPASS] LoadSafePatchModules - BLOCKED") end
function GameSafeCallbacks.InitPlayerData(a, b) end
function GameSafeCallbacks.TriggerRealtimeVerify(a) end
function GameSafeCallbacks.PlayerReport(a) end
function GameSafeCallbacks.WeaponReport(a, b) end
function GameSafeCallbacks.GetCoronaProofData() return "" end
function GameSafeCallbacks.GetClientCVarData() return "" end
function GameSafeCallbacks.TriggerCoronaLabVerify(a, b, c, d) end
function GameSafeCallbacks.CheckAOSValidSO(a) return false end
function GameSafeCallbacks.FilterGameMode(a) return false end
function GameSafeCallbacks.TestBan(a) end
function GameSafeCallbacks.CheckWorkModeFilter(a) return false end
function GameSafeCallbacks.BanPlayerForMultiCheatNew(a, b) end
function GameSafeCallbacks.CheckBanCo(a, b) end
function GameSafeCallbacks.ReportBanPlayer(a, b, c, d, e, f)
  print(string.format("[MASTER-BYPASS] ReportBanPlayer UID:%s Strategy:%s - BLOCKED", tostring(a), tostring(c)))
end
function GameSafeCallbacks.GetScriptReportContent(a, b) return "" end
function GameSafeCallbacks.DoAttackFlowStrategy(a) end
function GameSafeCallbacks.ReportNetworkData() end
function GameSafeCallbacks.ReportClientNetworkData() end
function GameSafeCallbacks.ReportClientCoronaData(a) end
function GameSafeCallbacks.TriggerTick(a) end
function GameSafeCallbacks.TriggerSlowTick(a) end
function GameSafeCallbacks.ConditionallyControlServerMove(a) end
function GameSafeCallbacks.RecordPlayerPing(a) end
function GameSafeCallbacks.CharacterReceiveBeginPlay(a) end
function GameSafeCallbacks.PostPlayerControllerLoginReconnect(a) end
function GameSafeCallbacks.PostPlayerControllerLoginInit(a) print("[MASTER-BYPASS] PostPlayerControllerLoginInit - BLOCKED") end
function GameSafeCallbacks.InitSwitchOnAntiCheatManager(a) end
function GameSafeCallbacks.IsPVSObfuscateEnabled() return false end
function GameSafeCallbacks.RecordStrategyTimestampInReplay(a, b, c, d) end
function GameSafeCallbacks.GetPlayerRealtimeVerifyInfo(a) return {} end
function GameSafeCallbacks.GetGameModeID() return -1 end
function GameSafeCallbacks.StartAreaIDTimer() end
function GameSafeCallbacks.ConditionallyGrayPublish(a, b, c, d) end
function GameSafeCallbacks.StartTimerToEnableFeatureInArea() end
function GameSafeCallbacks.DispatchStrategyConfig() end
function GameSafeCallbacks.ParseBaziConfigIntoBaziState(a) end
function GameSafeCallbacks.ParseConfigIntoBazi(a, b, c, d) return false end
function GameSafeCallbacks.ParseSingleStrategyConfig(a, b, c, d) return nil end
function GameSafeCallbacks.ParseSingleStrategyCondition(a, b) return nil end
function GameSafeCallbacks.ConvertStrategyValueString(a, b) return nil end
function GameSafeCallbacks.SendStrategyConfigAlertMessage(a) end
function GameSafeCallbacks.CallDSGlueHiaSystemPostControllerLogin(a) end
function GameSafeCallbacks.GetCompositeStrategyFieldName(a) return nil end
function GameSafeCallbacks.AlertSingleDimensionOfCompositeStrategy(a) end
function GameSafeCallbacks.EditorIncreaseTotalStatisticCnt(a) end
function GameSafeCallbacks.IsSoftPunishMultiDimensionChanged(a, b, c) return false end
function GameSafeCallbacks.EditorEnablePVSByConfigTable() end

-- =======================@RAHMANYVI=======================
-- 🔥 PART 11: STUBS FOR ALL 15 MODULES
-- =======================@RAHMANYVI=======================
local AllStrategyCfgLines_stub = {
  AssignCurrentCheatValue = function() end,
  GetStrategyValue = function() return 0 end,
  SetStrategyValue = function() end,
  CheckStrategy = function() end,
  IsStrategyActive = function() return false end,
  GetActiveStrategies = function() return {} end,
}
package.loaded["Server.security.AllStrategyCfgLines"] = AllStrategyCfgLines_stub
AllStrategyCfgLines = AllStrategyCfgLines_stub

local PlayerSafeCallback_stub = {
  InitPlayerSafeCallback = function() end,
  ReceivePlayerForbidMove = function() end,
  ReportPlayerForbidMove = function() end,
  CheckFlying = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  PostPlayerControllerLoginInit = function() end,
  PostPlayerControllerLoginReconnect = function() end,
  OnPlayerLogin = function() end,
  OnPlayerLogout = function() end,
  OnPlayerDie = function() end,
  OnPlayerRespawn = function() end,
  ReportPlayer = function() end,
  CheckPlayer = function() end,
  CheckPlayerSpeed = function() end,
  CheckPlayerFly = function() end,
  CheckPlayerJump = function() end,
  CheckPlayerPosition = function() end,
  OnPlayerSprint = function() end,
  OnPlayerCrouch = function() end,
  OnPlayerProne = function() end,
}
package.loaded["Server.security.PlayerSafeCallback"] = PlayerSafeCallback_stub
PlayerSafeCallback = PlayerSafeCallback_stub

local WeaponSafeCallback_stub = {
  InitWeaponSafeCallback = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  OnClientAnomalyCountUpload = function() end,
  PostPlayerControllerLoginInit = function() end,
  OnWeaponFire = function() end,
  OnWeaponReload = function() end,
  OnWeaponSwitch = function() end,
  CheckWeaponDamage = function() end,
  CheckWeaponRecoil = function() end,
  CheckBulletSpeed = function() end,
  CheckAutoAim = function() end,
  CheckBulletDir = function() end,
  CheckShootInterval = function() end,
}
package.loaded["Server.security.WeaponSafeCallback"] = WeaponSafeCallback_stub
WeaponSafeCallback = WeaponSafeCallback_stub

local VehicleSafeCallback_stub = {
  InitVehicleSafeCallback = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  PostPlayerControllerLoginInit = function() end,
  OnVehicleEnter = function() end,
  OnVehicleExit = function() end,
  CheckVehicleSpeed = function() end,
  CheckVehiclePosition = function() end,
  CheckVehicleFly = function() end,
  CheckVehicleMove = function() end,
}
package.loaded["Server.security.VehicleSafeCallback"] = VehicleSafeCallback_stub
VehicleSafeCallback = VehicleSafeCallback_stub

local ESPSafeCallback_stub = {
  InitESPSafeCallback = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  PostPlayerControllerLoginInit = function() end,
  OnReportESPCheat = function() end,
  CheckESPState = function() end,
  CheckESPTime = function() end,
  CheckESPCount = function() end,
  OnESPBattleInvisible = function() end,
  OnESPOpenScopeInvisible = function() end,
  OnESPContinueInvisible = function() end,
  OnESPSimTrace = function() end,
  OnESPImeFocus = function() end,
  CheckESPTotalTime = function() end,
  CheckESPTotalCnt = function() end,
}
package.loaded["Server.security.ESPSafeCallback"] = ESPSafeCallback_stub
ESPSafeCallback = ESPSafeCallback_stub

local IntegrityCheckCallback_stub = {
  InitIntegrityCheckCallback = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  OnReportIntegrityItemCheckResult = function() end,
  PostPlayerControllerLoginInit = function() end,
  CheckIntegrityItem = function() end,
  CheckFileIntegrity = function() end,
  CheckPakIntegrity = function() end,
  OnIntegrityFail = function() end,
  CheckMemoryRead = function() end,
}
package.loaded["Server.security.IntegrityCheckCallback"] = IntegrityCheckCallback_stub
IntegrityCheckCallback = IntegrityCheckCallback_stub

local AndroidObscuredCallback_stub = {
  InitAndroidObscuredCallback = function() end,
  PostPlayerControllerLoginInit = function() end,
  OnReportObscuredStatus = function() end,
  CheckObscuredStatus = function() end,
  OnObscuredDetected = function() end,
  CheckAndroidStatus = function() end,
}
package.loaded["Server.security.AndroidObscuredCallback"] = AndroidObscuredCallback_stub
AndroidObscuredCallback = AndroidObscuredCallback_stub

local SecurityCommon_stub = {
  Init = function() end,
  OnReportClientInfo = function() end,
  CheckClientInfo = function() end,
  GetSecurityLevel = function() return 0 end,
  SetSecurityLevel = function() end,
  IsSecurityEnabled = function() return false end,
  GetSecurityStatus = function() return {} end,
}
package.loaded["Server.security.SecurityCommon"] = SecurityCommon_stub
SecurityCommon = SecurityCommon_stub

local TickEncryptCallback_stub = {
  Init = function() end,
  PostPlayerControllerLoginInit = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  OnTickEncrypt = function() end,
  CheckTickEncrypt = function() end,
  VerifyTickEncrypt = function() end,
}
package.loaded["Server.security.TickEncryptCallback"] = TickEncryptCallback_stub
TickEncryptCallback = TickEncryptCallback_stub

local MoveInputCallback_stub = {
  Init = function() end,
  PostPlayerControllerLoginInit = function() end,
  TriggerSlowTick = function() end,
  OnMoveInput = function() end,
  CheckMoveInput = function() end,
  RecordMoveInput = function() end,
  VerifyMoveInput = function() end,
}
package.loaded["Server.security.MoveInputCallback"] = MoveInputCallback_stub
MoveInputCallback = MoveInputCallback_stub

local AutoAimConfig_stub = {
  Init = function() end,
  GetConfig = function() return {} end,
  CheckAutoAim = function() end,
  OnAutoAimDetected = function() end,
  IsAutoAim = function() return false end,
}
package.loaded["Server.security.AutoAimConfig"] = AutoAimConfig_stub
AutoAimConfig = AutoAimConfig_stub

local PeekShootVerifyCallback_stub = {
  PostPlayerControllerLoginInit = function() end,
  TriggerTick = function() end,
  TriggerSlowTick = function() end,
  OnReportPeekShootVerifyResult = function() end,
  CheckPeekShoot = function() end,
  VerifyPeekShoot = function() end,
  OnPeekShootDetected = function() end,
}
package.loaded["Server.security.PeekShootVerifyCallback"] = PeekShootVerifyCallback_stub
PeekShootVerifyCallback = PeekShootVerifyCallback_stub

local SecurityPakCallback_stub = {
  PostPlayerControllerLoginInit = function() end,
  TriggerSlowTick = function() end,
  OnServerReceiveInvalidFilesInPakLite = function() end,
  CheckPakFiles = function() end,
  VerifyPakFiles = function() end,
  OnPakCheckFailed = function() end,
  CheckFilesInPak = function() end,
}
package.loaded["Server.security.SecurityPakCallback"] = SecurityPakCallback_stub
SecurityPakCallback = SecurityPakCallback_stub

local BaziConfig_stub = {
  Init = function() end,
  GetConfig = function() return {} end,
  CheckBazi = function() end,
  OnBaziDetected = function() end,
}
package.loaded["Server.security.BaziConfig"] = BaziConfig_stub
BaziConfig = BaziConfig_stub

local AvatarCheckCallback_stub = {
  Init = function() end,
  PostPlayerControllerLoginInit = function() end,
  OnReportItemID = function() end,
  CheckAvatar = function() end,
  VerifyAvatar = function() end,
  OnAvatarDetected = function() end,
  CheckItemID = function() end,
}
package.loaded["Server.security.AvatarCheckCallback"] = AvatarCheckCallback_stub
AvatarCheckCallback = AvatarCheckCallback_stub

package.loaded["Server.security.GameSafeCallbacks"] = GameSafeCallbacks

-- =======================@RAHMANYVI=======================
-- 🔥 PART 12: CLEAR ALL EXISTING DATA
-- =======================@RAHMANYVI=======================
if GlobalPlayerCheatTimes then
  for k in pairs(GlobalPlayerCheatTimes) do GlobalPlayerCheatTimes[k] = nil end
end
if GlobalPlayerCoronaData then
  for k in pairs(GlobalPlayerCoronaData) do GlobalPlayerCoronaData[k] = nil end
end
if TestBanUIDSet then
  for k in pairs(TestBanUIDSet) do TestBanUIDSet[k] = nil end
end
if UID2PlayerKey then
  for k in pairs(UID2PlayerKey) do UID2PlayerKey[k] = nil end
end

-- =======================@RAHMANYVI=======================
-- 🔥 PART 13: FINAL LOG
-- =======================@RAHMANYVI=======================
sandbox.LogShippingDS("==============================================")
sandbox.LogShippingDS("GameSafeCallbacks.lua: FULL MASTER BYPASS LOADED")
sandbox.LogShippingDS("ALL 16 SECURITY MODULES DISABLED:")
sandbox.LogShippingDS("  1. GameSafeCallbacks         - DISABLED")
sandbox.LogShippingDS("  2. AllStrategyCfgLines       - DISABLED")
sandbox.LogShippingDS("  3. PlayerSafeCallback        - DISABLED")
sandbox.LogShippingDS("  4. WeaponSafeCallback        - DISABLED")
sandbox.LogShippingDS("  5. VehicleSafeCallback       - DISABLED")
sandbox.LogShippingDS("  6. ESPSafeCallback           - DISABLED")
sandbox.LogShippingDS("  7. IntegrityCheckCallback    - DISABLED")
sandbox.LogShippingDS("  8. AndroidObscuredCallback   - DISABLED")
sandbox.LogShippingDS("  9. SecurityCommon             - DISABLED")
sandbox.LogShippingDS(" 10. TickEncryptCallback       - DISABLED")
sandbox.LogShippingDS(" 11. MoveInputCallback         - DISABLED")
sandbox.LogShippingDS(" 12. AutoAimConfig             - DISABLED")
sandbox.LogShippingDS(" 13. PeekShootVerifyCallback   - DISABLED")
sandbox.LogShippingDS(" 14. SecurityPakCallback       - DISABLED")
sandbox.LogShippingDS(" 15. BaziConfig                - DISABLED")
sandbox.LogShippingDS(" 16. AvatarCheckCallback       - DISABLED")
sandbox.LogShippingDS("==============================================")

return {}

-- ==========================================
-- EXTRA BYPASS ASSET INTEGRITY
-- ==========================================
local function ExtraAssetBypass()
    pcall(function()
        local AM = import("AssetManager")
        if AM then
            AM.GetAssetHash = function() return "VALID_HASH" end
            AM.VerifyAsset = function() return true end
            AM.CheckModifiedAssets = function() return false end
        end
        local PKG = import("Package")
        if PKG then
            PKG.GetFileHash = function() return "00000000000000000000000000000000" end
            PKG.VerifyPackage = function() return true end
        end
        local FileHelper = import("FileHelper")
        if FileHelper then
            FileHelper.GetFileMD5 = function() return "00000000000000000000000000000000" end
            FileHelper.GetFileCRC = function() return 0 end
        end
        local Crypto = import("Crypto")
        if Crypto then
            Crypto.MD5 = function() return "00000000000000000000000000000000" end
            Crypto.SHA1 = function() return "0000000000000000000000000000000000000000" end
            Crypto.CRC32 = function() return 0 end
        end
    end)
end

local function InitializeLogBlocker()
    pcall(function()
        local ScreenshotMaker = import("ScreenshotMaker")
        if ScreenshotMaker then
            ScreenshotMaker.MakePicture = function() return "" end
            ScreenshotMaker.ReMakePicture = function() return "" end
            ScreenshotMaker.HasCaptured = function() return true end
        end
        local ScreenshotManager = import("ScreenshotManager")
        if ScreenshotManager then
            ScreenshotManager.RequestScreenshot = function() end
            ScreenshotManager.CaptureScreenshot = function() end
        end
        local MediaPlayer = import("MediaPlayer")
        if MediaPlayer then
            MediaPlayer.CaptureFrame = function() return nil end
        end
        local TLog = package.loaded["TLog"] or _G.TLog
        if TLog then
            TLog.Info = function() end
            TLog.Warning = function() end
            TLog.Error = function() end
            TLog.Debug = function() end
            TLog.Report = function() end
        end
        local CrashSight = package.loaded["CrashSight"] or _G.CrashSight
        if CrashSight then
            CrashSight.ReportException = function() end
            CrashSight.SetCustomData = function() end
            CrashSight.Log = function() end
        end
        local GameReportUtils = package.loaded["GameLua.Mod.BaseMod.GamePlay.GameReport.GameReportUtils"]
        if GameReportUtils then
            GameReportUtils.BugglyPostExceptionFull = function() return false end
            GameReportUtils.CheckCanBugglyPostException = function() return false end
            GameReportUtils.ReplayReportData = function() end
            GameReportUtils.ReportGameException = function() end
        end
        local ClientToolsReport = package.loaded["client.slua.logic.report.ClientToolsReport"]
        if ClientToolsReport then
            ClientToolsReport.SendReport = function() end
            ClientToolsReport.SendException = function() end
        end
        local tlog_report_utils = package.loaded["client.slua.config.tlog.tlog_report_utils"]
        if tlog_report_utils then
            tlog_report_utils.ReportTLogEvent = function() end
        end
    end)
end

local function InitializeScannerBlocker()
    pcall(function()
        local SubsystemMgr = require("GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        if SubsystemMgr then
            local afkSub = SubsystemMgr:Get("AFKReportorSubsystem")
            if afkSub then 
                afkSub.PlayerHaveAction = function() end
                afkSub.ReportAFK = function() end
            end
            local statsSub = SubsystemMgr:Get("ClientDataStatistcsSubsystem")
            if statsSub then
                statsSub.StartToCheck = function() end
                statsSub.DelayCount = 0
                if statsSub.ReportPingDelayTimer then
                    statsSub:RemoveGameTimer(statsSub.ReportPingDelayTimer)
                    statsSub.ReportPingDelayTimer = nil
                end
            end
            local avatarSub = SubsystemMgr:Get("AvatarExceptionSubsystem")
            if avatarSub then
                avatarSub.ReportException = function() end
                avatarSub.BindPlayerCharacter = function() end
                avatarSub.CheckAvatarValid = function() return true end
            end
            local shootSub = SubsystemMgr:Get("ShootVerifySubSystemClient")
            if shootSub then
                shootSub.ReportVerifyFail = function() end
                shootSub.OnVerifyFailed = function() end
            end
        end
        local CreativeModeBlueprintLibrary = import("CreativeModeBlueprintLibrary")
        if CreativeModeBlueprintLibrary then
            CreativeModeBlueprintLibrary.MD5HashByteArray = function() return "BYPASSED_MD5_HASH" end
            CreativeModeBlueprintLibrary.GetContentDiffData = function() return true, "BYPASSED" end
        end
        local FileCheckSubsystem = SubsystemMgr and SubsystemMgr:Get("FileCheckSubsystem")
        if FileCheckSubsystem then
            FileCheckSubsystem.GetFileHash = function() return "BYPASSED_HASH" end
            FileCheckSubsystem.VerifyFile = function() return true end
            FileCheckSubsystem.ReportFileMismatch = function() end
        end
        local STExtraBlueprintFunctionLibrary = import("STExtraBlueprintFunctionLibrary")
        if STExtraBlueprintFunctionLibrary then
            STExtraBlueprintFunctionLibrary.MD5HashByteArray = function() return "BYPASSED_MD5" end
            STExtraBlueprintFunctionLibrary.GetFileHash = function() return "BYPASSED_MD5" end
        end
        local TssSdk = package.loaded["TssSdk"] or _G.TssSdk
        if TssSdk then
            local originalOnRecv = TssSdk.OnRecvData
            TssSdk.OnRecvData = function(data)
                if type(data) == "string" and (string.find(data, "report") or string.find(data, "exception")) then
                    return
                end
                if originalOnRecv then originalOnRecv(data) end
            end
            TssSdk.SendReportInfo = function() end
            TssSdk.ScanMemory = function() return true end
            TssSdk.IsEmulator = function() return false end
            TssSdk.GetTssSdkReportInfo = function() return "" end
            TssSdk.SendAntiData = function() end
            TssSdk.ReportGameSuspicious = function() end
            TssSdk.SendSignatureData = function() end
            TssSdk.EnableCheck = false
        end
    end)
end

local function InitializeReplayTelemetryBlocker()
    pcall(function()
        local SubsystemMgr = require("GameLua.GameCore.Module.Subsystem.SubsystemMgr")
        local replaySub = SubsystemMgr and SubsystemMgr:Get("RescueBtnReplayTraceSubsystem")
        if replaySub then
            replaySub.ReportTrace = function() end
            replaySub.StartTickMonitor = function() end
            replaySub.TickMonitorCheck = function() end
            replaySub.ReportTickMonitorHeartbeat = function() end
        end
        local gameReportSub = SubsystemMgr and SubsystemMgr:Get("GameReportSubsystem")
        if gameReportSub then
            gameReportSub.ReplayReportData = function() return false end
            gameReportSub.CheckCanBugglyPostException = function() return false end
            gameReportSub.BugglyPostExceptionFull = function() return false end
            gameReportSub.GetClientReplayDataReporter = function() return nil end
        end
        local logic_report_replay = package.loaded["client.slua.logic.replay.logic_report_replay"]
        if logic_report_replay then
            logic_report_replay.ReportReplay = function() end
            logic_report_replay.SendReportReq = function() end
        end
    end)
end

local function DisableHiggsBoson()
    local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
    if not pc or not slua.isValid(pc) then return end
    if pc.HiggsBoson then
        pc.HiggsBoson.bMHActive = false
        pc.HiggsBoson.bCallPreReplication = false
    end
    if pc.HiggsBosonComponent then
        pc.HiggsBosonComponent.bMHActive = false
        pc.HiggsBosonComponent:ControlMHActive(0)
    end
end

local function InitializeAntiCheatHooks()
    pcall(function()
        local HiggsBosonComponent = require("GameLua.Mod.BaseMod.Common.Security.HiggsBosonComponent")
        if HiggsBosonComponent and HiggsBosonComponent.StaticShowSecurityAlertInDev then
            HiggsBosonComponent.StaticShowSecurityAlertInDev = function() end
        end
    end)
    pcall(function()
        local HiggsBosonComponent = require("GameLua.Mod.BaseMod.Common.Security.HiggsBosonComponent")
        if HiggsBosonComponent and HiggsBosonComponent.BlackList then
            for k in pairs(HiggsBosonComponent.BlackList) do HiggsBosonComponent.BlackList[k] = nil end
        end
    end)
    _G.BlackList = {}
    pcall(function()
        _G.GlobalPlayerCoronaData = _G.GlobalPlayerCoronaData or {}
        _G.GlobalPlayerCheatTimes = _G.GlobalPlayerCheatTimes or {}
        local mt = getmetatable(_G.GlobalPlayerCoronaData) or {}
        mt.__newindex = function(t, k, v) end
        setmetatable(_G.GlobalPlayerCoronaData, mt)
    end)
    pcall(function()
        local STExtraBlueprintFunctionLibrary = import("STExtraBlueprintFunctionLibrary")
        if STExtraBlueprintFunctionLibrary then
            STExtraBlueprintFunctionLibrary.IsDevelopment = function() return false end
        end
    end)
end

local function InitializeAntiReport()
    pcall(function()
        local reportPaths = { 
            "GameLua.Mod.BaseMod.Client.Security.ClientReportPlayerSubsystem", 
            "Client.Security.ClientReportPlayerSubsystem" 
        }
        local reportSub = nil
        for _, path in ipairs(reportPaths) do
            if package.loaded[path] then reportSub = package.loaded[path] break end
            local success, module = pcall(require, path)
            if success and module then reportSub = module break end
        end
        if reportSub then
            reportSub.OnInit = function(self) return end
            reportSub._OnPlayerKilledOtherPlayer = function() return end
            reportSub._RecordFatalDamager = function() return end
            reportSub._OnDeathReplayDataWhenFatalDamaged = function() return end
            reportSub._RecordMurdererFromDeathReplayData = function() return end
            reportSub._RecordTeammatePlayerInfo = function() return end
            reportSub._OnBattleResult = function() return end
            reportSub._OnShowQuickReportMutualExclusiveUI = function() return end
            reportSub.GetFatalDamagerMap = function() return {} end
            reportSub.GetCachedTeammateName2InfoMap = function() return {} end
            reportSub.GetTeammateName2InfoMapDuringBattle = function() return {} end
            reportSub.GetCurrentNotInTeamHistoricalTeammateMap = function() return {} end
            reportSub.GetInTeamIndexFromHistoricalTeammateInfo = function() return -1 end
        end
    end)
    pcall(function()
        local dsReportPaths = { 
            "GameLua.Mod.BaseMod.DS.Security.DSReportPlayerSubsystem", 
            "GameLua.Mod.BaseMod.Client.Security.DSReportPlayerSubsystem" 
        }
        local dsReport = nil
        for _, path in ipairs(dsReportPaths) do
            if package.loaded[path] then dsReport = package.loaded[path] break end
            local success, module = pcall(require, path)
            if success and module then dsReport = module break end
        end
        if dsReport then
            dsReport.OnInit = function(self) return end
            dsReport._OnNearDeathOrRescued = function() return end
            dsReport._OnCharacterDied = function() return end
            dsReport._OnTeammateDamage = function() return end
            dsReport._OnPlayerSettlementStart = function() return end
            dsReport._AddKnockDownerToBattleResult = function() return end
            dsReport._AddKillerToBattleResult = function() return end
            dsReport._AddTeammateMurderToBattleResult = function() return end
            dsReport._AddFatalDamagerMapToBattleResult = function() return end
            dsReport._AddMLKillerUIDToBattleResult = function() return end
            dsReport._SaveHistoricalTeammateInfo = function() return end
            dsReport._RecordFatalDamager = function() return end
            dsReport._RecordTeammateMurderer = function() return end
        end
    end)
    pcall(function()
        local ReportPlayerUtils = require("GameLua.Mod.BaseMod.Common.Security.ReportPlayerUtils")
        if ReportPlayerUtils then
            ReportPlayerUtils.RecordFatalDamager = function() return end
            ReportPlayerUtils.IsUsingHistoricalTeammateInfo = function() return false end
            ReportPlayerUtils.IsCharacterDeliverAI = function() return false end
        end
    end)
    pcall(function()
        local SecurityCommonUtilsMod = require("GameLua.Mod.BaseMod.Common.Security.SecurityCommonUtils")
        if SecurityCommonUtilsMod then
            SecurityCommonUtilsMod.ExtractPlayerBasicInfo = function() return {} end
            SecurityCommonUtilsMod.LogIf = function() return false end
        end
    end)
end

local function InitializeInspectionAndReportBypass()
    pcall(function()
        local inspectClientPath = "GameLua.Mod.BaseMod.Client.Security.InspectionSystemReportClientLogicSubsystem"
        local InspectClient = package.loaded[inspectClientPath] or require(inspectClientPath)
        if InspectClient then
            InspectClient.AskForInspector = function() end
            InspectClient.ReportEnemy = function() end
            InspectClient.KickOutOneTeam = function() end
            InspectClient.GetReportData = function() return {} end
        end
        local inspectDSPath = "GameLua.Mod.BaseMod.DS.Security.InspectionSystemReportDSLogicSubsystem"
        local InspectDS = package.loaded[inspectDSPath] or require(inspectDSPath)
        if InspectDS then
            InspectDS.ServerKickOutOneTeamByPlayerImplementation = function() end
            InspectDS.AddReportedCount = function() end
            InspectDS.GetReportData = function() return {} end
            InspectDS.ReportPlayerToPolice = function() end
            InspectDS.HandlePoliceResponse = function() end
        end
        local quickReportPath = "client.slua.logic.report.logic_quick_report"
        local QuickReport = package.loaded[quickReportPath] or require(quickReportPath)
        if QuickReport then
            QuickReport.SendQuickReport = function() end
            QuickReport.GetQuickReportInfo = function() return {} end
        end
        local replayReportPath = "client.slua.logic.replay.logic_report_replay"
        local ReplayReport = package.loaded[replayReportPath] or require(replayReportPath)
        if ReplayReport then
            ReplayReport.ReportReplay = function() end
            ReplayReport.SendReportReq = function() end
        end
    end)
end

local function InitializeGameplayBypass()
    pcall(function()
        if not _G.GameplayCallbacks or _G.GameplayCallbacks.IsBypassed then return end
        local GC = _G.GameplayCallbacks
        local var_129 = GC.OnDSPlayerStateChanged
        GC.OnDSPlayerStateChanged = function(UID, InPlayerState, bPureWatcher, bIsSafeExit, ParamReason)
            if InPlayerState and string.lower(tostring(InPlayerState)) == "cheatdetected" then return end
            if var_129 then return var_129(UID, InPlayerState, bPureWatcher, bIsSafeExit, ParamReason) end
        end
        local function noop() return end
        local function emptyTable() return {} end
        local function nilFunc() return nil end
        GC.ReportAttackFlow = noop
        GC.ReportSecAttackFlow = noop
        GC.ReportHurtFlow = noop
        GC.ReportFireArms = noop
        GC.ReportVerifyInfoFlow = noop
        GC.ReportMrpcsFlow = noop
        GC.ReportPlayerBehavior = noop
        GC.ReportTeammatHurt = noop
        GC.ReportMisKillByTeammate = noop
        GC.ReportForbitPick = noop
        GC.ReportPlayerMoveRoute = noop
        GC.ReportPlayerPosition = noop
        GC.ReportVehicleMoveFlow = noop
        GC.ReportSecTgameMovingFlow = noop
        GC.ReportParachuteData = noop
        GC.SendTssSdkAntiDataToLobby = noop
        GC.SendDSErrorLogToLobby = noop
        GC.SendDSErrorLogToLobbyOnece = noop
        GC.SendDSHawkEyePatrolLogToLobby = noop
        GC.ReportEquipmentFlow = noop
        GC.ReportAimFlow = noop
        GC.GetWeaponReport = emptyTable
        GC.GetOneWeaponReport = emptyTable
        GC.ReportHeavyWeaponBoxSpawnFlow = noop
        GC.ReportHeavyWeaponBoxActivationFlow = noop
        GC.ReportHeavyWeaponBoxOpenPlayerFlow = noop
        GC.ReportHeavyWeaponBoxItemFlow = noop
        GC.ReportPlayersPing = noop
        GC.ReportPlayerIP = noop
        GC.ReportPlayerFramePingRecord = noop
        GC.OnDSConnectionSaturated = noop
        GC.ReportDSNetSaturation = noop
        GC.ReportNetContinuousSaturate = noop
        GC.ReportDSNetRate = noop
        GC.SendClientStats = noop
        GC.SendServerAvgTickDelta = noop
        GC.ReportCircleFlow = noop
        GC.ReportDSCircleFlow = noop
        GC.ReportJumpFlow = noop
        GC.ReportAIStrategyInfo = noop
        GC.SendAIDeliveryInfo = noop
        GC.ReportDailyTaskInfo = noop
        GC.ReportMatchRoomData = noop
        GC.SendPlayerSpectatingLog = noop
        GC.ReportIDCardProduceFlow = noop
        GC.ReportIDCardPickUpFlow = noop
        GC.ReportIDCardDestroyFlow = noop
        GC.ReportRevivalFlow = noop
        GC.ReportGameSetting = noop
        GC.ReportGameSettingNew = noop
        GC.ReportAntsVoiceTeamCreate = noop
        GC.ReportAntsVoiceTeamQuit = noop
        GC.ReportCommonInfo = noop
        GC.ReportLightweightStat = noop
        GC.SendSecTLog = noop
        GC.SendDataMiningTLog = noop
        GC.SendActivityTLog = noop
        GC.GetGeneralTLogData = nilFunc
        GC.IsBypassed = true
    end)
    pcall(function()
        if NetUtil and NetUtil.SendPacket and not NetUtil.IsBypassed then
            local originalSend = NetUtil.SendPacket
            local blockedPackets = {
                ["ReportAttackFlow"]=1, ["ReportSecAttackFlow"]=1, ["ReportHurtFlow"]=1,
                ["ReportFireArms"]=1, ["ReportVerifyInfoFlow"]=1, ["ReportMrpcsFlow"]=1,
                ["ReportPlayerBehavior"]=1, ["ReportTeammatHurt"]=1, ["ReportTeammateKillConfirmFlow"]=1,
                ["ReportForbiddenPickupFlow"]=1, ["ReportPlayerMoveRoute"]=1, ["ReportPlayerPosition"]=1,
                ["ReportSecVehicleMoveFlow"]=1, ["ReportSecTgameMovingFlow"]=1, ["report_parachute_data"]=1,
                ["report_character_all_drag"]=1, ["report_parachute_all_drag"]=1, ["report_vehicle_move_drag"]=1,
                ["on_tss_sdk_anti_data"]=1, ["report_unrealnet_exception"]=1, ["ReportPlayerEquipmentInfo"]=1,
                ["ReportAimFlow"]=1, ["ReportHitFlow"]=1, ["log_shooting_miss"]=1, ["report_heavy_weapon_box_activation_flow"]=1,
                ["report_heavy_weapon_box_item_flow"]=1, ["ReportCircleFlow"]=1, ["report_ds_player_circle_flow"]=1,
                ["ReportJumpFlow"]=1, ["ReportGameStartFlow"]=1, ["ReportGameEndFlow"]=1, ["report_players_ping"]=1,
                ["report_player_ip"]=1, ["report_player_frame_ping_record"]=1, ["report_net_saturate"]=1,
                ["report_ds_netsaturate"]=1, ["report_ds_net_continuous_saturate"]=1, ["report_ds_netrate"]=1,
                ["report_unrealnet_clientstats"]=1, ["report_serverstat_avgtickdelta"]=1, ["report_all_players_address"]=1,
                ["report_ai_strategyinfo"]=1, ["ReportAIActionFlow"]=1, ["ReportGenerateMonsterFlow"]=1,
                ["report_ds_match_room_data"]=1, ["SendSpectatingLog"]=1, ["ReportIDCardProduceFlow"]=1,
                ["ReportIDCardPickUpFlow"]=1, ["ReportIDCardDestroyFlow"]=1, ["ReportRevivalFlow"]=1,
                ["ReportGameSetting"]=1, ["ReportGameSettingNew"]=1, ["ReportAntsVoiceTeamCreate"]=1,
                ["ReportAntsVoiceTeamQuit"]=1, ["report_common_info"]=1, ["report_common_battle_info"]=1,
                ["report_client_scan_result"]=1, ["tss_sdk_report"]=1, ["report_memory_exception"]=1,
                ["report_avatar_exception"]=1, ["report_ui_state"]=1, ["report_hit_reg_fail"]=1,
                ["report_character_state"]=1, ["report_vehicle_exception"]=1, ["report_camera_exception"]=1,
                ["ReportPlayerControllerStateChanged"]=1, ["ReportAvatarFlow"]=1,
            }
            NetUtil.SendPacket = function(packetName, ...)
                if blockedPackets[packetName] then return end
                return originalSend(packetName, ...)
            end
            NetUtil.IsBypassed = true
        end
    end)
end

local function InitializeConnectionGuard()
    pcall(function()
        if _G.ConnectionGuardInitialized or not _G.GameplayCallbacks then return end
        local GC = _G.GameplayCallbacks
        local var_129 = GC.OnDSPlayerStateChanged
        GC.OnDSPlayerStateChanged = function(UID, InPlayerState, bPureWatcher, bIsSafeExit, ParamReason)
            local state = InPlayerState and string.lower(tostring(InPlayerState)) or ""
            local blockedStates = {
                ["cheatdetected"] = true, ["connectionlost"] = true,
                ["connectiontimeout"] = true, ["connectionexception"] = true,
                ["netdrivererror"] = true
            }
            if blockedStates[state] then return end
            if var_129 then
                pcall(var_129, UID, InPlayerState, bPureWatcher, bIsSafeExit, ParamReason)
            end
        end
        GC.OnPlayerNetConnectionClosed = function(GameID, UID, Reason, ErrorMessage) end
        GC.OnPlayerActorChannelError = function(GameID, UID, Reason, ErrorMessage) end
        GC.OnPlayerRPCValidateFailed = function(GameID, UID, Reason, ErrorMessage) end
        GC.OnPlayerSpectateException = function(GameID, UID, Reason, ErrorMessage) end
        GC.OnShutdownAfterError = function(GameID) end
        _G.ConnectionGuardInitialized = true
    end)
end

local function InitializeZRPRBypasses()
    pcall(function()
        local noop = function() end
        local returnTrue = function() return true end
        local returnEmpty = function() return {} end
        local stExtraBlueprint = import("STExtraBlueprintFunctionLibrary")
        if stExtraBlueprint then 
            stExtraBlueprint.IsDevelopment = returnTrue 
        end
        if _G.BasicDataTLogReport then
            _G.BasicDataTLogReport.OnSendBatchReqMsg = noop
            _G.BasicDataTLogReport.OnImmediateReqMsg = noop
            _G.BasicDataTLogReport.send_report_event_duration_log = noop
            _G.BasicDataTLogReport.SendTlog = noop
        end
        if _G.TApmHelper then 
            _G.TApmHelper.postEvent = noop 
        end
        local sdm = _G.ServerDataMgr
        if sdm and sdm.DeletablePlayerResultKey then
            sdm.DeletablePlayerResultKey["SuspiciousHitCount"] = true
            sdm.DeletablePlayerResultKey["EspTotalSimTraceCnt"] = true
            sdm.DeletablePlayerResultKey["EspTotalImeFocusCnt"] = true
            sdm.DeletablePlayerResultKey["ClientGravityAnomalyCount"] = true
        end
        local hiaPath = "GameLua.Mod.BaseMod.Client.Security.ClientGlueHiaSystem"
        local hia = package.loaded[hiaPath] or require(hiaPath)
        if hia then
            hia.CheckHitIntegrity = returnTrue
            hia.InitSession = noop
            hia.OnBattleEnd = noop
        end
        if _G.ClientGlueHiaSystem then 
            _G.ClientGlueHiaSystem.CheckHitIntegrity = returnTrue 
        end
        local secUtilsPath = "GameLua.Mod.BaseMod.Common.Security.SecurityCommonUtils"
        local secUtils = package.loaded[secUtilsPath] or require(secUtilsPath)
        if secUtils and secUtils.EStrategyTypeInReplay then
            secUtils.EStrategyTypeInReplay.EspTotalSimTraceCnt = 0
            secUtils.EStrategyTypeInReplay.EspTotalImeFocusCnt = 0
            secUtils.EStrategyTypeInReplay.ClientGravityAnomalyCount = 0
            secUtils.EStrategyTypeInReplay.FlyingErrorCnt = 0
        end
        local pcNotifyPath = "GameLua.Mod.BaseMod.Common.Security.SecurityNotifyPCFeature"
        local pcNotify = package.loaded[pcNotifyPath] or require(pcNotifyPath)
        if pcNotify then
            pcNotify.ClientRPC_SyncBanID = noop
            pcNotify.ClientRPC_StrongTips = noop
            pcNotify.ClientRPC_NormalTips = noop
            pcNotify.Notify = noop
        end
        local clientBanLogicPath = "client.slua.logic.ban.ClientBanLogic"
        local ClientBanLogic = package.loaded[clientBanLogicPath] or require(clientBanLogicPath)
        if ClientBanLogic then
            ClientBanLogic.OnSyncBanInfo = noop
            ClientBanLogic.OnVoiceBanNotify = noop
        end
        local ttBanPath = "client.slua.logic.login.logic_tt_ban"
        local logic_tt_ban = package.loaded[ttBanPath] or require(ttBanPath)
        if logic_tt_ban then
            logic_tt_ban.GetCarrierInfo = function() return "[{\"mcc\":\"000\"}]" end
            logic_tt_ban.CheckIfCanCreateRole = returnTrue
        end
        local dsActivePath = "GameLua.Mod.PlanBT.Gameplay.Subsystem.DSActiveSubsystem"
        local DSActive = package.loaded[dsActivePath] or require(dsActivePath)
        if DSActive then
            DSActive.DelayKickOutPlayer = noop
            DSActive.ActiveKickNotify = noop
        end
        local dsAITLogPath = "GameLua.Mod.BaseMod.DS.Security.DSAITLogSubsystem"
        local DSAITLog = package.loaded[dsAITLogPath] or require(dsAITLogPath)
        if DSAITLog then
            DSAITLog._UpdateTTKRecords = noop
            DSAITLog._UpdateOperatingFrequency = noop
        end
        local dsFightTLogPath = "GameLua.Mod.BaseMod.DS.Security.DSFightTLogSubsystem"
        local DSFightTLog = package.loaded[dsFightTLogPath] or require(dsFightTLogPath)
        if DSFightTLog then 
            DSFightTLog.GetSimpleFightData = returnEmpty 
        end
        local dsSecurityPath = "GameLua.Mod.BaseMod.DS.Security.DSSecurityTLogSubsystem"
        local DSSecurity = package.loaded[dsSecurityPath] or require(dsSecurityPath)
        if DSSecurity then 
            DSSecurity._OnReportServerJumpFlow = noop 
        end
        local dsCommonPath = "GameLua.Mod.BaseMod.DS.Security.DSCommonTLogSubsystem"
        local DSCommon = package.loaded[dsCommonPath] or require(dsCommonPath)
        if DSCommon then 
            DSCommon.HandleKillTlog = noop 
        end
        local dsReportPath = "GameLua.Mod.BaseMod.DS.Security.DSReportPlayerSubsystem"
        local DSReport = package.loaded[dsReportPath] or require(dsReportPath)
        if DSReport then 
            DSReport._AddEnemyMapToBattleResult = noop 
        end
        local inspectClientPath = "GameLua.Mod.BaseMod.Client.Security.InspectionSystemReportClientLogicSubsystem"
        local InspectClient = package.loaded[inspectClientPath] or require(inspectClientPath)
        if InspectClient then
            InspectClient.AskForInspector = noop
            InspectClient.ReportEnemy = noop
            InspectClient.KickOutOneTeam = noop
        end
        local inspectDSPath = "GameLua.Mod.BaseMod.DS.Security.InspectionSystemReportDSLogicSubsystem"
        local InspectDS = package.loaded[inspectDSPath] or require(inspectDSPath)
        if InspectDS then
            InspectDS.ServerKickOutOneTeamByPlayerImplementation = noop
            InspectDS.AddReportedCount = noop
        end
        local spectateReplayPath = "GameLua.Mod.BaseMod.Common.Subsystem.SpectateAndReplaySubsystem"
        local SpectateReplay = package.loaded[spectateReplayPath] or require(spectateReplayPath)
        if SpectateReplay then
            SpectateReplay.RequestGotoSpectatingImp = noop
            SpectateReplay.RequestGotoSpectating = noop
        end
        local clientHawkEyePath = "GameLua.Mod.BaseMod.Client.Security.ClientHawkEyePatrolSubsystem"
        local ClientHawkEye = package.loaded[clientHawkEyePath] or require(clientHawkEyePath)
        if ClientHawkEye then
            ClientHawkEye._OnHawkSync = noop
            ClientHawkEye._OnHawkReportSuccess = noop
            ClientHawkEye._StartExitGameTimer = noop
        end
        local behaviorScorePath = "GameLua.Mod.Escape.Gameplay.Subsystem.BehaviorScoreSubsystem"
        local BehaviorScore = package.loaded[behaviorScorePath] or require(behaviorScorePath)
        if BehaviorScore then
            BehaviorScore.OnHandleBehaviorScore = noop
            BehaviorScore.AIPerceptionScore = noop
        end
        local aiReplayPath = "GameLua.ExtraModule.MLAI.Client.AIReplaySubsystem"
        local AIReplay = package.loaded[aiReplayPath] or require(aiReplayPath)
        if AIReplay then
            AIReplay.ReportAllPlayerInfo = noop
            if AIReplay.uCompletePlayBack then 
                AIReplay.uCompletePlayBack.AddRecordMLAIInfo = noop 
            end
        end
        local aiTrackingPath = "GameLua.Mod.BaseMod.GamePlay.AI.AITrackingLogSubsystem"
        local AITracking = package.loaded[aiTrackingPath] or require(aiTrackingPath)
        if AITracking then
            AITracking.RealLogoutTimer = noop
            AITracking.LogQueue = {}
        end
        local tdmAFKPath = "GameLua.Mod.TDM.Gameplay.Subsystem.TDMAFKReportorSubsystem"
        local TDMAFK = package.loaded[tdmAFKPath] or require(tdmAFKPath)
        if TDMAFK then
            TDMAFK.SendAFKTips = noop
            TDMAFK.OnHandleLostConnection = noop
        end
        local dataMgrPath = "client.slua.logic.data.data_mgr"
        local DataMgr = package.loaded[dataMgrPath] or _G.DataMgr
        if DataMgr then
            DataMgr.GetWeaponSkinSoundVolumeInfoByGroup = function() return 0 end
        end
    end)

    -- ✅ FIXED: BigHead bypass via GameplayData metatable (was GameplayData_3 typo)
    pcall(function()
        local EAvatarDamagePosition = import("EAvatarDamagePosition")
        if EAvatarDamagePosition and EAvatarDamagePosition.BigHead then
            local GameplayDataModule = require("GameLua.GameCore.Data.GameplayData")
            if GameplayDataModule then
                local meta = getmetatable(GameplayDataModule) or {}
                local oldIndex = meta.__index
                meta.__index = function(t, k)
                    if k == "GetHitBodyType" then
                        return function(...) return EAvatarDamagePosition.BigHead end
                    end
                    if type(oldIndex) == "table" then return oldIndex[k] end
                    if type(oldIndex) == "function" then return oldIndex(t, k) end
                    return nil
                end
                setmetatable(GameplayDataModule, meta)
            end
        end
    end)
end

local function BypassACE()
    pcall(function()
        local ace_check = package.loaded["libace.so"] or _G.ace
        if ace_check then
            ace_check.ReportData = function() end
            ace_check.CheckIntegrity = function() return true end
            ace_check.ScanMemory = function() return false end
        end
        local ace_jni = _G.JNI and _G.JNI.ACE
        if ace_jni then
            ace_jni.reportException = function() end
            ace_jni.collectEvidence = function() return nil end
        end
    end)
end

local function BypassXignCode3()
    pcall(function()
        local xigncode = package.loaded["xigncode"] or _G.XignCode
        if xigncode then
            xigncode.SendReport = function() end
            xigncode.CheckProcess = function() return true end
            xigncode.VerifyIntegrity = function() return true end
            xigncode.ScanModules = function() return {} end
        end
    end)
end

local function BypassBattlEye()
    pcall(function()
        local battleye = package.loaded["BattlEye"] or _G.BattlEye
        if battleye then
            battleye.SendReport = function() end
            battleye.KickPlayer = function() end
            battleye.ValidatePlayer = function() return true end
            battleye.CheckMemory = function() return true end
        end
    end)
end

local function BypassMemoryScanner()
    pcall(function()
        local memory_scanner = package.loaded["MemoryScanner"] or _G.MemScan
        if memory_scanner then
            memory_scanner.StartScan = function() end
            memory_scanner.StopScan = function() end
            memory_scanner.GetResults = function() return {} end
            memory_scanner.ReportViolation = function() end
        end
        _G.bMemoryScanning = false
        _G.bIntegrityCheck = true
    end)
end

local function BypassPacketEncryption()
    pcall(function()
        local encryptor = package.loaded["PacketEncrypt"] or _G.Encryptor
        if encryptor then
            encryptor.Encrypt = function(data) return data end
            encryptor.Decrypt = function(data) return data end
            encryptor.VerifyChecksum = function() return true end
        end
        local secure_channel = _G.SecureChannel
        if secure_channel then
            secure_channel.ValidatePacket = function() return true end
            secure_channel.LogPacket = function() end
        end
    end)
end

local function BypassDSValidation()
    pcall(function()
        local ds_validator = package.loaded["DSValidator"] or _G.DSValidation
        if ds_validator then
            dsValidator.ValidateClient = function() return true end
            dsValidator.CheckLatency = function() return 40 end
            dsValidator.ReportCheat = function() end
        end
        _G.bDSKick = false
        _G.DSKickReason = nil
    end)
end

local function BypassCRCCheck()
    pcall(function()
        local crc_checker = package.loaded["CRCChecker"] or _G.CRC
        if crc_checker then
            crc_checker.VerifyFile = function() return true end
            crc_checker.VerifyMemory = function() return true end
            crc_checker.GenerateCRC = function() return "00000000" end
        end
        _G.OnIntegrityFailure = nil
    end)
end

local function BypassJNIAntiCheat()
    pcall(function()
        local jni_ac = _G.JNI and _G.JNI.AntiCheat
        if jni_ac then
            jni_ac.CheckRoot = function() return false end
            jni_ac.CheckEmulator = function() return false end
            jni_ac.CheckDebugger = function() return false end
            jni_ac.CollectInfo = function() return {} end
            jni_ac.SendReport = function() end
        end
    end)
end

local function BypassTDataMaster()
    pcall(function()
        local tdatamaster = package.loaded["libTDataMaster.so"] or _G.TDataMaster
        if tdatamaster then
            tdatamaster.ReportEvent = function() end
            tdatamaster.ReportException = function() end
            tdatamaster.FlushData = function() end
            tdatamaster.CollectData = function() return {} end
        end
        _G.TelemetryQueue = {}
        _G.bTelemetryEnabled = false
    end)
end

local function BypassAntiDebug()
    pcall(function()
        local debugger_check = package.loaded["DebuggerDetect"] or _G.Debug
        if debugger_check then
            debugger_check.IsDebuggerPresent = function() return false end
            debugger_check.CheckBreakpoint = function() return false end
            debugger_check.CheckTracer = function() return false end
        end
        local emu_check = package.loaded["EmulatorDetect"] or _G.Emulator
        if emu_check then
            emu_check.IsEmulator = function() return false end
            emu_check.GetEmulatorType = function() return "" end
            emu_check.CheckVM = function() return false end
        end
        _G.ProcStatus = {
            TracerPid = "0",
            State = "S (sleeping)"
        }
    end)
end

local function FakeSystemInfo()
    pcall(function()
        local SystemInfo = import("SystemInfo")
        if SystemInfo then
            SystemInfo.GetDeviceModel = function() return "iPhone14,5" end
            SystemInfo.GetDeviceBrand = function() return "Apple" end
            SystemInfo.GetAndroidVersion = function() return "13" end
            SystemInfo.GetEMUIVersion = function() return "" end
            SystemInfo.IsEmulator = function() return false end
            SystemInfo.IsRooted = function() return false end
            SystemInfo.IsDebugged = function() return false end
        end
        local KernelManager = package.loaded["client.slua.logic.system.KernelManager"]
        if KernelManager then
            KernelManager.GetKernelVersion = function() return "Linux version 4.14.116" end
            KernelManager.CheckKernelIntegrity = function() return true end
        end
    end)
end

local function EncryptMemoryOperations()
    pcall(function()
        local MemoryProtect = import("MemoryProtect")
        if MemoryProtect then
            MemoryProtect.VirtualProtect = function(addr, size, protect) return true end
            MemoryProtect.IsMemoryReadable = function(addr) return false end
            MemoryProtect.IsMemoryWritable = function(addr) return false end
        end
    end)
end

local function KillAllLogging()
    pcall(function()
        _G.print = function() end
        _G.printf = function() end
        _G.log = function() end
        _G.warn = function() end
        _G.error = function() end
        local Logging = import("Logging")
        if Logging then
            Logging.Log = function() end
            Logging.LogWarning = function() end
            Logging.LogError = function() end
            Logging.SetLogLevel = function() end
        end
        local FileHelper = import("FileHelper")
        if FileHelper then
            FileHelper.WriteToFile = function() end
            FileHelper.SaveStringToFile = function() return true end
            FileHelper.CreateFileWriter = function() return nil end
        end
    end)
end

local function RandomizeBehavior()
    pcall(function()
        local InputManager = import("InputManager")
        if InputManager then
            local origGetMouseDelta = InputManager.GetMouseDelta
            InputManager.GetMouseDelta = function()
                local delta = origGetMouseDelta()
                if delta then
                    delta.X = delta.X + (math.random(-2, 2) * 0.1)
                    delta.Y = delta.Y + (math.random(-2, 2) * 0.1)
                end
                return delta
            end
        end
    end)
end

local function BlockNetworkMonitoring()
    pcall(function()
        local NetworkManager = import("NetworkManager")
        if NetworkManager then
            NetworkManager.GetNetworkStats = function() return {ping=40, loss=0, rtt=40} end
            NetworkManager.CapturePackets = function() end
            NetworkManager.AnalyzeTraffic = function() return {} end
            NetworkManager.GetConnectionInfo = function() return "127.0.0.1:8080" end
        end
    end)
end

local function SpoofTimingChecks()
    pcall(function()
        local Engine = import("Engine")
        if Engine then
            Engine.GetAverageFPS = function() return 60 end
            Engine.GetFrameTime = function() return 0.016 end
            Engine.IsLagging = function() return false end
        end
        local GameTime = package.loaded["GameLua.GameCore.Data.GameTime"]
        if GameTime then
            GameTime.GetServerTime = function() return os.time() end
            GameTime.GetDeltaTime = function() return 0.033 end
        end
    end)
end

local function PreventSuspiciousFlags()
    pcall(function()
        local suspiciousVars = {
            "bIsCheating", "bDetected", "bBanned", "SuspicionScore",
            "CheatDetected", "AntiCheatFlag", "IsHacking", "bReported",
            "TrustScore", "SecurityFlag", "ViolationLevel", "BanStatus"
        }
        for _, var in ipairs(suspiciousVars) do
            _G[var] = nil
        end
        local meta = getmetatable(_G) or {}
        local oldNewIndex = meta.__newindex
        meta.__newindex = function(t, k, v)
            for _, var in ipairs(suspiciousVars) do
                if string.find(tostring(k), var, 1, true) then return end
            end
            if oldNewIndex then oldNewIndex(t, k, v) else rawset(t, k, v) end
        end
        setmetatable(_G, meta)
    end)
end

local function AddDetectionJitter()
    pcall(function()
        local origSend = NetUtil and NetUtil.Send
        if NetUtil and origSend then
            NetUtil.Send = function(data)
                local delay = math.random(10, 100) / 1000
                return origSend(data)
            end
        end
    end)
end

local function SelfModifyingProtection()
    pcall(function()
        local checkInterval = 30
        local lastCheck = os.time()
        local function memoryScanDetector()
            local current = os.time()
            if current - lastCheck > checkInterval then lastCheck = current end
        end
        local timer = 0
        local originalUpdate = _G.Update
        _G.Update = function(dt)
            timer = timer + dt
            if timer > 5 then timer = 0; memoryScanDetector() end
            if originalUpdate then originalUpdate(dt) end
        end
    end)
end

local function BlockHiggsBosonComplete()
    pcall(function()
        local HiggsBosonComponent = package.loaded["GameLua.Mod.BaseMod.Common.Security.HiggsBosonComponent"]
        if HiggsBosonComponent then
            HiggsBosonComponent.bIsEnable = false
            HiggsBosonComponent.CheckClientConfig = function() return false end
            HiggsBosonComponent.GetSecurityInfo = function() return {} end
        end
    end)
end

local function AntiScreenshotDetection()
    pcall(function()
        local ScreenshotDetection = import("ScreenshotDetection")
        if ScreenshotDetection then
            ScreenshotDetection.OnScreenshotTaken = function() end
            ScreenshotDetection.ReportScreenshot = function() end
        end
        local AndroidPermission = import("AndroidPermission")
        if AndroidPermission then
            AndroidPermission.CheckPermission = function() return true end
        end
    end)
end

local function ForceDisableDebugMode()
    pcall(function()
        local DebugTools = import("DebugTools")
        if DebugTools then
            DebugTools.IsDebugMode = function() return false end
            DebugTools.EnableDebug = function() end
        end
        if _G.DEBUG then _G.DEBUG = false end
        if _G._DEBUG then _G._DEBUG = false end
    end)
end

local function AdditionalBypass()
    pcall(function()
        local STExtraBaseCharacter = import("STExtraBaseCharacter")
        if STExtraBaseCharacter then
            STExtraBaseCharacter.OnRep_Health = function() end
            STExtraBaseCharacter.OnRep_HealthMax = function() end
            STExtraBaseCharacter.OnRep_bIsDead = function() end
        end
        local STExtraPlayerState = import("STExtraPlayerState")
        if STExtraPlayerState then
            STExtraPlayerState.OnRep_bIsABot = function() end
            STExtraPlayerState.OnRep_bIsBot = function() end
        end
        local UGameInstance = import("GameInstance")
        if UGameInstance then
            UGameInstance.HandleNetworkError = function() end
            UGameInstance.HandleTravelError = function() end
        end
        local KismetSystemLibrary2 = import("KismetSystemLibrary")
        if KismetSystemLibrary2 then
            KismetSystemLibrary2.IsDebugBuild = function() return false end
            KismetSystemLibrary2.IsShippingBuild = function() return true end
        end
    end)
end

-- ✅ SAFE WRAPPER — runs all bypasses in order with pcall
local function SafeRunAllBypasses()
    local steps = {
        ExtraAssetBypass, InitializeLogBlocker, InitializeScannerBlocker,
        InitializeReplayTelemetryBlocker, DisableHiggsBoson, InitializeAntiCheatHooks,
        InitializeAntiReport, InitializeInspectionAndReportBypass, InitializeGameplayBypass,
        InitializeConnectionGuard, InitializeZRPRBypasses, BypassACE, BypassXignCode3,
        BypassBattlEye, BypassMemoryScanner, BypassPacketEncryption, BypassDSValidation,
        BypassCRCCheck, BypassJNIAntiCheat, BypassTDataMaster, BypassAntiDebug,
        FakeSystemInfo, EncryptMemoryOperations, KillAllLogging, RandomizeBehavior,
        BlockNetworkMonitoring, SpoofTimingChecks, PreventSuspiciousFlags, AddDetectionJitter,
        SelfModifyingProtection, BlockHiggsBosonComplete, AntiScreenshotDetection,
        ForceDisableDebugMode, AdditionalBypass,
    }
    local ok_count = 0
    for _, fn in ipairs(steps) do
        if pcall(fn) then ok_count = ok_count + 1 end
    end
    print(string.format("[BRPlayerCharacterBase] Bypass initialized: %d/%d", ok_count, #steps))
end

-- ✅ RUN BYPASSES BEFORE CLASS REGISTRATION
SafeRunAllBypasses()

-- ===================================================================================
-- ==================== ONLINE KEY VERIFICATION SYSTEM (from SHAYAN tool) ================
-- ===================================================================================

local function GetSafeTime()
  local ok, t = pcall(function() return os.time(os.date("!*t")) end)
  if ok and t and t > 0 then return t end
  local ok2, t2 = pcall(os.time)
  if ok2 and t2 and t2 > 0 then return t2 end
  return 1728000000
end

-- ============================================================
-- LICENSE SYSTEM — C++ loader matched, complete
-- ============================================================
_G.__SHD_LICENSE = _G.__SHD_LICENSE or {}
local _L = _G.__SHD_LICENSE

_L.API_URL = "https://grwauth.lat/connect"
_L.LICENSE_GAMES = "PUBG"
_L.APP_VERSION = "1.0.0"
_L.SECRET_SUFFIX = "DIAMONDYT"

_L.KeyStorePaths = _L.KeyStorePaths or {
    "/sdcard/BRPlay/.brplay_license_key",
    "/storage/emulated/0/BRPlay/.brplay_license_key",
    "/sdcard/Android/data/com.tencent.ig/files/.brplay_license_key",
    "/storage/emulated/0/Android/data/com.tencent.ig/files/.brplay_license_key",
    "./.brplay_license_key",
    "brplay_license.key"
}

_L.LoadSavedKey = function()
    local cached = _G.__SHD_LICENSE_KEY or _L.CachedKey or ""
    if cached ~= "" then return tostring(cached) end

    local function pref_get()
        local value = nil
        pcall(function()
            if luajava then
                local ActivityThread = luajava.bindClass("android.app.ActivityThread")
                local app = ActivityThread.currentApplication()
                if app then
                    local prefs = app:getSharedPreferences("brplay_license", 0)
                    value = prefs:getString("saved_license_key", nil)
                end
            end
        end)
        return value
    end

    local prefKey = pref_get()
    if prefKey and tostring(prefKey) ~= "" then
        prefKey = tostring(prefKey):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[%r%n%s]+", "")
        if prefKey ~= "" then
            _L.CachedKey = prefKey
            _G.__SHD_LICENSE_KEY = prefKey
            _L.KeyStorePath = "SharedPreferences"
            return prefKey
        end
    end

    if not io or not io.open then return "" end
    for _, path in ipairs(_L.KeyStorePaths) do
        local f = nil
        pcall(function() f = io.open(path, "r") end)
        if f then
            local k = f:read("*a") or ""
            pcall(function() f:close() end)
            k = tostring(k):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[%r%n%s]+", "")
            if k ~= "" then
                _L.CachedKey = k
                _G.__SHD_LICENSE_KEY = k
                _L.KeyStorePath = path
                return k
            end
        end
    end
    return ""
end

_L.SaveKey = function(key)
    key = tostring(key or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[%r%n%s]+", "")
    if key == "" then return false end

    local prefSaved = false
    pcall(function()
        if luajava then
            local ActivityThread = luajava.bindClass("android.app.ActivityThread")
            local app = ActivityThread.currentApplication()
            if app then
                local prefs = app:getSharedPreferences("brplay_license", 0)
                local editor = prefs:edit()
                editor:putString("saved_license_key", key)
                editor:apply()
                prefSaved = true
            end
        end
    end)

    if prefSaved then
        _L.KeyStorePath = "SharedPreferences"
        _L.CachedKey = key
        _G.__SHD_LICENSE_KEY = key
        return true
    end

    if not io or not io.open then return false end
    for _, path in ipairs(_L.KeyStorePaths) do
        local f = nil
        pcall(function() f = io.open(path, "w") end)
        if f then
            local ok = pcall(function()
                f:write(key)
                if f.flush then f:flush() end
                f:close()
            end)
            if ok then
                _L.KeyStorePath = path
                _L.CachedKey = key
                _G.__SHD_LICENSE_KEY = key
                return true
            end
            pcall(function() f:close() end)
        end
    end
    return false
end

_L.CachedKey = _L.LoadSavedKey()
_L.InputWidget = nil
_L.InputBox = nil
_L.InputButton = nil
_L.InputRoot = nil
_L.InputParent = nil
_L.InputStatusLabel = nil
_L.InputBusy = false
_L.InputWidgets = _L.InputWidgets or {}

_L.ShowPopup = function(title, msg)
    pcall(function()
        local Msg = require("client.slua.logic.common.logic_common_msg_box")
        if Msg and Msg.Show then Msg.Show(4, title, msg) end
    end)
end

_L.CloseInput = function()
    local parent = _L.InputParent
    pcall(function()
        if _L.InputWidgets then
            for i = #_L.InputWidgets, 1, -1 do
                local w = _L.InputWidgets[i]
                pcall(function()
                    if w and slua.isValid(w) then
                        if w.SetVisibility then
                            w:SetVisibility(UEnums.ESlateVisibility.Collapsed)
                        end
                    end
                end)
                pcall(function()
                    if parent and slua.isValid(parent) and w and slua.isValid(w) and parent.RemoveChild then
                        parent:RemoveChild(w)
                    end
                end)
                pcall(function()
                    if w and slua.isValid(w) and w.RemoveFromParent then
                        w:RemoveFromParent()
                    end
                end)
                _L.InputWidgets[i] = nil
            end
        end
    end)
    pcall(function()
        if _L.InputRoot and slua.isValid(_L.InputRoot) then
            if _L.InputRoot.SetVisibility then
                _L.InputRoot:SetVisibility(UEnums.ESlateVisibility.Collapsed)
            end
            if _L.InputRoot.RemoveFromParent then
                _L.InputRoot:RemoveFromParent()
            end
        end
    end)
    _L.InputRoot = nil
    _L.InputParent = nil
    _L.InputBox = nil
    _L.InputButton = nil
    _L.InputWidget = nil
    _L.InputStatusLabel = nil
    _L.InputBusy = false
end

_L.GetMainCanvas = function()
    local canvas = nil
    pcall(function()
        local tools = require("GameLua.Mod.BaseMod.Common.UI.InGameUITools")
        local ui = tools and tools.GetMainControlBaseUI and tools.GetMainControlBaseUI()
        if ui and slua.isValid(ui) then
            if ui.CanvasPanel_0 and slua.isValid(ui.CanvasPanel_0) then
                canvas = ui.CanvasPanel_0
            elseif ui.CanvasPanel_42 and slua.isValid(ui.CanvasPanel_42) then
                canvas = ui.CanvasPanel_42
            end
        end
    end)
    return canvas
end

_L.AddClick = function(button, fn)
    if not button or not fn then return false end
    local ok = false
    pcall(function()
        if button.OnClicked and button.OnClicked.Add then
            button.OnClicked:Add(fn)
            ok = true
        end
    end)
    if not ok then
        pcall(function()
            if button.OnClicked and button.OnClicked.AddUnique then
                button.OnClicked:AddUnique(fn)
                ok = true
            end
        end)
    end
    return ok
end

_L.AddPress = function(button, fn)
    if not button or not fn then return false end
    local ok = false
    pcall(function()
        if button.OnPressed and button.OnPressed.Add then
            button.OnPressed:Add(fn)
            ok = true
        end
    end)
    if not ok then
        pcall(function()
            if button.OnPressed and button.OnPressed.AddUnique then
                button.OnPressed:AddUnique(fn)
                ok = true
            end
        end)
    end
    return ok
end

_L.GetText = function(box)
    if not box then return "" end
    local text = nil
    pcall(function()
        if box.GetText then text = box:GetText() end
    end)
    if text == nil then return "" end
    pcall(function()
        if text.ToString then text = text:ToString() end
    end)
    text = tostring(text or "")
    text = text:gsub("^%s+", ""):gsub("%s+$", "")
    text = text:gsub("[%r%n]+", "")
    return text
end

-- ============================================================
-- LOGIN UI (blue heading, key input, contact info bold, red status)
-- ============================================================
_L.ShowKeyInput = function(callback)
    if _L.InputBusy then return end
    _L.InputBusy = true

    local Parent = _L.GetMainCanvas()
    if not Parent or not slua.isValid(Parent) then
        _L.InputBusy = false
        _L.ShowPopup("LICENSE ERROR", "Game UI is not ready. Please wait a moment and try again.")
        return
    end

    _L.CloseInput()
    _L.InputBusy = true
    _L.InputParent = Parent

    local V2 = import("Vector2D") or FVector2D
    local LC = import("LinearColor") or FLinearColor
    local SC = import("SlateColor") or import("/Script/SlateCore.SlateColor")

    local ViewW, ViewH = 1920, 1080
    pcall(function()
        local PC = nil
        if PlayerMapMarker and PlayerMapMarker.GetMyPlayerController then PC = PlayerMapMarker.GetMyPlayerController() end
        if PC and PC.GetViewportSize then
            local VS = V2(0, 0)
            PC:GetViewportSize(VS)
            if VS and VS.X and VS.Y and VS.X > 200 and VS.Y > 200 then
                ViewW, ViewH = VS.X, VS.Y
            end
        end
    end)

    local DialogW, DialogH = 560, 300
    local DialogX = math.max(0, (ViewW - DialogW) * 0.5)
    local DialogY = math.max(0, (ViewH - DialogH) * 0.5)

    local Root = nil
    pcall(function() Root = CGame:NewObjectFromPath("/Script/UMG.CanvasPanel", Parent) end)
    if not Root or not slua.isValid(Root) then
        _L.InputBusy = false
        _L.ShowPopup("LICENSE ERROR", "Unable to create license input UI.")
        return
    end

    local function centerSlot(widget, size, offsetX, offsetY, z)
        if not widget then return nil end
        local slot = Parent:AddChildToCanvas(widget)
        if not slot then return nil end

        local localPos = nil

        pcall(function()
            local SBL = SlateBlueprintLibrary
            local cg = Parent:GetCachedGeometry()
            if SBL and SBL.AbsoluteToLocal and cg then
                local screenCenter = V2(ViewW * 0.5, ViewH * 0.5)
                local topLeftAbs = V2(
                    screenCenter.X - (size.X * 0.5) + (offsetX or 0) - 310,
                    screenCenter.Y - (size.Y * 0.5) + (offsetY or 0) - 225
                )
                localPos = SBL.AbsoluteToLocal(cg, topLeftAbs)
            end
        end)

        if not localPos then
            pcall(function()
                local WLL = WidgetLayoutLibrary
                local cg = Parent:GetCachedGeometry()
                if WLL and WLL.ScreenToWidgetLocal and cg then
                    local screenCenter = V2(ViewW * 0.5, ViewH * 0.5)
                    local topLeftAbs = V2(
                        screenCenter.X - (size.X * 0.5) + (offsetX or 0),
                        screenCenter.Y - (size.Y * 0.5) + (offsetY or 0)
                    )
                    local outPos = V2(0, 0)
                    WLL.ScreenToWidgetLocal(
                        PlayerMapMarker.GetMyPlayerController(),
                        cg,
                        topLeftAbs,
                        outPos
                    )
                    localPos = outPos
                end
            end)
        end

        if not localPos then
            localPos = V2(
                (ViewW - size.X) * 0.5 + (offsetX or 0) - 310,
                (ViewH - size.Y) * 0.5 + (offsetY or 0) - 225
            )
        end

        pcall(function()
            if slot.SetPosition then slot:SetPosition(localPos) end
            if slot.SetSize then slot:SetSize(size) end
            if slot.SetAlignment then slot:SetAlignment(V2(0, 0)) end
            if slot.SetZOrder then slot:SetZOrder(z or 99991) end
        end)

        return slot
    end

    local Dim = nil
    pcall(function() Dim = CGame:NewObjectFromPath("/Script/UMG.Border", Parent) end)
    if Dim and slua.isValid(Dim) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Dim
        pcall(function()
            Dim:SetBrushColor(LC(0, 0, 0, 0.62))
            Dim:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        end)
        local ds = Parent:AddChildToCanvas(Dim)
        pcall(function()
            local A = import("Anchors") or import("/Script/SlateCore.Anchors")
            if A and ds and ds.SetAnchors then ds:SetAnchors(A(0,0,1,1)) end
            if ds and ds.SetZOrder then ds:SetZOrder(99990) end
        end)
    end

    local DialogW, DialogH = 560, 340

    local Panel = nil
    pcall(function() Panel = CGame:NewObjectFromPath("/Script/UMG.Border", Parent) end)
    if not Panel or not slua.isValid(Panel) then
        _L.CloseInput()
        _L.ShowPopup("LICENSE ERROR", "Unable to create license dialog.")
        return
    end
    _L.InputWidgets[#_L.InputWidgets + 1] = Panel
    pcall(function()
        Panel:SetBrushColor(LC(0.015, 0.015, 0.02, 0.97))
        Panel:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
    end)
    centerSlot(Panel, V2(DialogW,DialogH), 0, 0, 99991)

    local Header = nil
    pcall(function() Header = CGame:NewObjectFromPath("/Script/UMG.Border", Parent) end)
    if Header and slua.isValid(Header) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Header
        pcall(function() Header:SetBrushColor(LC(0.02,0.05,0.08,1.0)) end)
        centerSlot(Header, V2(DialogW,54), 0, -DialogH*0.5 + 27, 99992)
    end

    local Accent = nil
    pcall(function() Accent = CGame:NewObjectFromPath("/Script/UMG.Border", Parent) end)
    if Accent and slua.isValid(Accent) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Accent
        pcall(function() Accent:SetBrushColor(LC(0.0,0.85,1.0,1.0)) end)
        centerSlot(Accent, V2(6,54), -DialogW*0.5 + 3, -DialogH*0.5 + 27, 99993)
    end

    -- Blue/cyan heading
    local Title = nil
    pcall(function() Title = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Parent) end)
    if Title and slua.isValid(Title) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Title
        pcall(function()
            Title:SetText("➤ ENTER YOUR ✦ BUY KEY 03319741588")
            local c = LC(0.0,0.85,1.0,1.0)
            if SC then Title:SetColorAndOpacity(SC(c)) else Title:SetColorAndOpacity(c) end
            if Title.Font then local f=Title.Font; f.Size=22; f.TypefaceFontName = "Bold"; Title.Font=f end
        end)
        centerSlot(Title, V2(480,40), -DialogW*0.5 + 265, -DialogH*0.5 + 27, 99994)
    end

    local Close = nil
    pcall(function() Close = CGame:NewObjectFromPath("/Script/UMG.Button", Parent) end)
    if Close and slua.isValid(Close) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Close
        pcall(function() Close:SetColorAndOpacity(LC(0.85,0.02,0.03,1.0)) end)
        local xt = nil
        pcall(function() xt = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Close) end)
        if xt and slua.isValid(xt) then
            _L.InputWidgets[#_L.InputWidgets + 1] = xt
            pcall(function()
                xt:SetText("X")
                if xt.Font then local f=xt.Font; f.Size=24; xt.Font=f end
            end)
            pcall(function() Close:AddChild(xt) end)
        end
        centerSlot(Close, V2(45,54), DialogW*0.5 - 22.5, -DialogH*0.5 + 27, 99995)
        _L.AddClick(Close, function()
            pcall(function() if Box and Box.SetKeyboardFocus then Box:SetKeyboardFocus() end end)
        end)
        _L.AddPress(Close, function()
            pcall(function() if Box and Box.SetKeyboardFocus then Box:SetKeyboardFocus() end end)
        end)
    end

    -- Key input
    local Box = nil
    pcall(function() Box = CGame:NewObjectFromPath("/Script/UMG.EditableTextBox", Parent) end)
    if not Box or not slua.isValid(Box) then
        _L.CloseInput()
        _L.ShowPopup("LICENSE ERROR", "This game build does not expose UMG EditableTextBox to Lua.")
        return
    end
    _L.InputWidgets[#_L.InputWidgets + 1] = Box
    pcall(function()
        if Box.SetHintText then Box:SetHintText("Enter your license key...") end
        if Box.SetIsReadOnly then Box:SetIsReadOnly(false) end
        if Box.SetIsPassword then Box:SetIsPassword(false) end
        if Box.SetText then Box:SetText(_L.CachedKey or "") end
         if Box.SetBackgroundColor then Box:SetBackgroundColor(LC(0.035,0.035,0.045,0.98)) end
         if Box.SetForegroundColor then Box:SetForegroundColor(LC(1.0,1.0,1.0,1.0)) end
    end)
    centerSlot(Box, V2(380,55), 0, -DialogH*0.5 + 130, 99996)
    _L.InputBox = Box

    -- Username / contact / number displayed underneath (bold/prominent)
    local ContactLabel = nil
    pcall(function() ContactLabel = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Parent) end)
    if ContactLabel and slua.isValid(ContactLabel) then
        _L.InputWidgets[#_L.InputWidgets + 1] = ContactLabel
        pcall(function()
            ContactLabel:SetText("Don't have a key? Contact Owner to buy\n\nTelegram: @SHAYAN_TOOL1  |  WhatsApp: +92 [03319741588]")
            local c = LC(1.0, 1.0, 1.0, 1.0)
            if SC then ContactLabel:SetColorAndOpacity(SC(c)) else ContactLabel:SetColorAndOpacity(c) end
            if ContactLabel.Font then local f=ContactLabel.Font; f.Size=14; f.TypefaceFontName = "Bold"; ContactLabel.Font=f end
        end)
        centerSlot(ContactLabel, V2(500,22), 0, -DialogH*0.5 + 175, 99996)
    end

    -- Server status / error message underneath (RED)
    local StatusLabel = nil
    pcall(function() StatusLabel = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Parent) end)
    if StatusLabel and slua.isValid(StatusLabel) then
        _L.InputWidgets[#_L.InputWidgets + 1] = StatusLabel
        pcall(function()
            StatusLabel:SetText("")
            local c = LC(1.0,0.15,0.15,1.0)
            if SC then StatusLabel:SetColorAndOpacity(SC(c)) else StatusLabel:SetColorAndOpacity(c) end
            if StatusLabel.Font then local f=StatusLabel.Font; f.Size=13; StatusLabel.Font=f end
        end)
        centerSlot(StatusLabel, V2(500,40), 0, -DialogH*0.5 + 210, 99996)
        _L.InputStatusLabel = StatusLabel
    end

    local Btn = nil
    pcall(function() Btn = CGame:NewObjectFromPath("/Script/UMG.Button", Parent) end)
    if not Btn or not slua.isValid(Btn) then
        _L.CloseInput()
        _L.ShowPopup("LICENSE ERROR", "Unable to create OK button.")
        return
    end
    _L.InputWidgets[#_L.InputWidgets + 1] = Btn
    pcall(function()
        if Btn.SetColorAndOpacity then Btn:SetColorAndOpacity(LC(0.10,0.45,0.85,1.0)) end
    end)
    local Bt = nil
    pcall(function() Bt = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Parent) end)
    if Bt and slua.isValid(Bt) then
        _L.InputWidgets[#_L.InputWidgets + 1] = Bt
        pcall(function()
            Bt:SetText("LOGIN")
            if Bt.Font then local f=Bt.Font; f.Size=20; f.TypefaceFontName = "Bold"; Bt.Font=f end
        end)
        pcall(function() Btn:AddChild(Bt) end)
    end
    centerSlot(Btn, V2(180,58), 0, DialogH*0.5 - 40, 99997)
    _L.InputButton = Btn

    _L.InputSubmitLocked = false
    _L.AddClick(Btn, function()
        if _L.InputSubmitLocked == true or _G.LicenseChecking == true then return end
        _L.InputSubmitLocked = true
        _G.LicenseSessionCancelled = false
        local key = _L.GetText(Box)
        if key == "" then
            _L.InputSubmitLocked = false
            if _L.InputStatusLabel and slua.isValid(_L.InputStatusLabel) then
                _L.InputStatusLabel:SetText("Please enter your license key")
            end
            pcall(function() if Box.SetKeyboardFocus then Box:SetKeyboardFocus() end end)
            return
        end
        _L.CachedKey = key
        _G.__SHD_LICENSE_KEY = key
        _L.InputBusy = false
        if callback then callback(key, false) end
    end)

    _L.InputRoot = Panel
    pcall(function()
        if Box.SetKeyboardFocus then Box:SetKeyboardFocus() end
    end)
    return true
end

_L.GetHWID = function()
    local hwid = nil
    pcall(function()
        local Kismet = import('/Script/Engine.KismetSystemLibrary')
        if Kismet and Kismet.GetDeviceId then
            local v = Kismet.GetDeviceId()
            if v and tostring(v) ~= "" then hwid = tostring(v) end
        end
    end)
    if not hwid then
        pcall(function()
            local SystemLib = import("KismetSystemLibrary")
            if SystemLib and SystemLib.GetDeviceId then
                local v = SystemLib.GetDeviceId()
                if v and tostring(v) ~= "" then hwid = tostring(v) end
            end
        end)
    end
    return hwid or "UNKNOWN"
end

_L.UrlEncode = function(value)
    value = tostring(value or "")
    value = value:gsub("\n", "\r\n")
    return value:gsub("([^%w%-%._~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
end

_L.JsonString = function(resp, field)
    return string.match(resp, '"' .. field .. '"%s*:%s*"([^"]*)"')
end

_L.JsonNumber = function(resp, field)
    local value = string.match(resp, '"' .. field .. '"%s*:%s*(-?%d+%.?%d*)')
    return value and tonumber(value) or nil
end

_L.GetReason = function(resp)
    return _L.JsonString(resp, "reason")
        or _L.JsonString(resp, "message")
        or _L.JsonString(resp, "msg")
        or "Validation Failed"
end

_G.IsLicenseOK = function()
    return _G.LicenseValid == true and _G.ModsEnabled == true
end

_G.License_Validate = function(callback)
    if _G.LicenseSessionCancelled == true then
        _G.LicenseValid = false
        _G.ModsEnabled = false
        if callback then callback(false) end
        return
    end

    -- Persistent login: if a key was previously saved, validate it directly
    -- against the server. The login UI is shown only when there is no saved key
    -- or when the server rejects the saved key.
    if _G.LicenseSessionKeyConfirmed ~= true then
        local savedKey = _L.CachedKey or _G.__SHD_LICENSE_KEY or ""
        savedKey = tostring(savedKey):gsub("^%s+", ""):gsub("%s+$", "")
        savedKey = savedKey:gsub("[%r%n%s]+", "")

        if savedKey ~= "" then
            _L.CachedKey = savedKey
            _G.__SHD_LICENSE_KEY = savedKey
            _G.LicenseSessionKeyConfirmed = true
        else
            if _G.LicenseChecking == true or _L.InputBusy == true then return end
            _L.ShowKeyInput(function(key, cancelled)
                if cancelled or not key or tostring(key) == "" then
                    _G.LicenseSessionKeyConfirmed = false
                    if callback then callback(false) end
                    return
                end
                _L.CachedKey = tostring(key):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[%r%n%s]+", "")
                _G.__SHD_LICENSE_KEY = _L.CachedKey
                _G.LicenseSessionKeyConfirmed = true
                _G.License_Validate(callback)
            end)
            return
        end
    end

    if _G.LicenseValid == true then
        if callback then callback(true) end
        return
    end
    if _G.LicenseChecking == true or _L.InputBusy == true then return end

    local userKey = _L.CachedKey or _G.__SHD_LICENSE_KEY or ""
    userKey = tostring(userKey):gsub("^%s+", ""):gsub("%s+$", "")
    userKey = userKey:gsub("[%r%n%s]+", "")

    if userKey == "" then
        _G.LicenseSessionKeyConfirmed = false
        _L.ShowKeyInput(function(key, cancelled)
            if cancelled or not key then
                if callback then callback(false) end
                return
            end
            _L.CachedKey = key
            _G.__SHD_LICENSE_KEY = key
            _G.LicenseSessionKeyConfirmed = true
            _G.License_Validate(callback)
        end)
        return
    end

    local userHWID = _L.GetHWID()
    if not userHWID or userHWID == "" then userHWID = "UNKNOWN" end

    local ok, http = pcall(function()
        local MM = rawget(_G, "ModuleManager")
        if not MM then
            local okReq, mod = pcall(require, "client.module_framework.ModuleManager")
            if okReq and mod then MM = mod end
        end
        if not MM then return nil end
        return MM.GetModule(MM.CommonModuleConfig.http_manager)
    end)
    if not ok or not http or not http.Post then
        _L.ShowPopup("LICENSE ERROR", "HTTP manager not available")
        if callback then callback(false) end
        return
    end

    local c_rng = tostring(GetSafeTime())
    local postData = "game=" .. _L.UrlEncode(_L.LICENSE_GAMES)
        .. "&user_key=" .. _L.UrlEncode(userKey)
        .. "&serial=" .. _L.UrlEncode(userHWID)
        .. "&verrr=" .. _L.UrlEncode(_L.APP_VERSION)
        .. "&c_rng=" .. _L.UrlEncode(c_rng)

    local headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded",
        ["Accept"] = "application/json",
        ContentType = "application/x-www-form-urlencoded",
        contentType = "application/x-www-form-urlencoded"
    }

    _G.LicenseChecking = true

    -- Update the status label while checking
    pcall(function()
        if _L.InputStatusLabel and slua.isValid(_L.InputStatusLabel) then
            _L.InputStatusLabel:SetText("Verifying with server...")
        end
    end)

    local function extractStr(x)
        if x == nil then return nil end
        if type(x) == "string" and #x > 2 then return x end
        if type(x) == "number" then return nil end
        if type(x) == "table" then
            if type(x.body) == "string" and #x.body > 2 then return x.body end
            if type(x.Body) == "string" and #x.Body > 2 then return x.Body end
            if type(x.Content) == "string" and #x.Content > 2 then return x.Content end
            if type(x.content) == "string" and #x.content > 2 then return x.content end
            if type(x.data) == "string" and #x.data > 2 then return x.data end
            local okEnc, j = pcall(function()
                local cjson = require("cjson")
                return cjson.encode(x)
            end)
            if okEnc and j and #j > 2 then return j end
        end
        return nil
    end

    local function getResponse(a, b)
        local sa = extractStr(a)
        local sb = extractStr(b)
        local function looksJson(s)
            if not s then return false end
            if string.find(s, "{", 1, true) then return true end
            return false
        end
        if looksJson(sa) then return sa end
        if looksJson(sb) then return sb end
        return sa or sb or ""
    end

    local postOk, postErr = pcall(function()
        http:Post(_L.API_URL, headers, postData, nil, function(a, b)
            _G.LicenseChecking = false

            local response = getResponse(a, b)
            response = tostring(response or "")
            response = response:gsub("^%s+", ""):gsub("%s+$", "")

            print("[LICENSE DEBUG] Response length: " .. tostring(#response))
            if #response > 0 and #response < 600 then
                print("[LICENSE DEBUG] Response: " .. response)
            end

            local validated = false
            local errorMessage = "Bad Server Response"

            if response ~= "" and string.find(response, "{", 1, true) then
                local parsed = nil
                pcall(function()
                    local cjson = require("cjson")
                    parsed = cjson.decode(response)
                end)

                local status_val = nil
                local data_obj = nil

                if parsed then
                    status_val = parsed.status
                    if status_val == nil then status_val = parsed.success end
                    data_obj = parsed.data or parsed
                end

                if status_val == nil then
                    if string.find(response, '"status"%s*:%s*true') then
                        status_val = true
                    elseif string.find(response, '"success"%s*:%s*true') then
                        status_val = true
                    else
                        status_val = false
                    end
                end

                if status_val == true then
                    local token, exp, rng, modname, modStatus, credit, expiredDate, enc
                    if data_obj and type(data_obj) == "table" then
                        token       = data_obj.token
                        exp         = data_obj.EXP or data_obj.exp or data_obj.expiry
                        rng         = data_obj.rng
                        modname     = data_obj.modname or data_obj.mod_name
                        modStatus   = data_obj.mod_status or data_obj.status_text
                        credit      = data_obj.credit
                        expiredDate = data_obj.expired_date or data_obj.expiry_date
                        enc         = data_obj.Enc or data_obj.enc
                    end
                    if not token then token = _L.JsonString(response, "token") end
                    if not exp then exp = _L.JsonString(response, "EXP") end
                    if not rng then rng = _L.JsonNumber(response, "rng") end
                    if not modname then modname = _L.JsonString(response, "modname") end
                    if not modStatus then modStatus = _L.JsonString(response, "mod_status") end
                    if not credit then credit = _L.JsonString(response, "credit") end
                    if not expiredDate then expiredDate = _L.JsonString(response, "expired_date") end
                    if not enc then enc = _L.JsonString(response, "Enc") end

                    if exp then _G.LicenseEXP = exp end
                    if rng then _G.LicenseRng = rng end
                    if token then _G.LicenseToken = token end
                    if modname then _G.LicenseModName = modname end
                    if modStatus then _G.LicenseModStatus = modStatus end
                    if credit then _G.LicenseCredit = credit end
                    if expiredDate then _G.LicenseExpiredDate = expiredDate end
                    if enc then _G.LicenseEnc = enc end
                    validated = true
                else
                    if parsed and type(parsed) == "table" then
                        errorMessage = parsed.reason or parsed.message or parsed.msg
                            or _L.GetReason(response)
                    else
                        errorMessage = _L.GetReason(response)
                    end
                end
            elseif response == "" then
                errorMessage = "Empty Server Response - Check internet"
            else
                errorMessage = "Server Error: " .. tostring(response):sub(1, 80)
            end

            if validated then
                _G.LicenseValid = true
                _G.ModsEnabled = true
                _G.LicenseSessionKeyConfirmed = true
                _G._MOD_EXPIRED = false
                _L.CloseInput()
                _L.SaveKey(userKey)
                print("[LICENSE] VALID - Mods enabled")
                if callback then callback(true) end
            else
                _G.LicenseValid = false
                _G.ModsEnabled = false
                _G.LicenseSessionKeyConfirmed = false
                _L.InputBusy = false
                _L.InputSubmitLocked = false

                -- IMPORTANT: A rejected key must NEVER dismiss the login gate.
                -- Keep the license screen active until the server returns status=true.
                -- Do not save the rejected key.
                _L.CachedKey = ""
                _G.__SHD_LICENSE_KEY = ""

                -- Display the ACTUAL server response in RED under the login form
                pcall(function()
                    if _L.InputStatusLabel and slua.isValid(_L.InputStatusLabel) then
                        _L.InputStatusLabel:SetText(tostring(errorMessage))
                    end
                end)

                pcall(function()
                    if _L.InputRoot and slua.isValid(_L.InputRoot) then
                        if _L.InputRoot.SetVisibility then
                            _L.InputRoot:SetVisibility(UEnums.ESlateVisibility.Visible)
                        end
                        if _L.InputBox and _L.InputBox.SetText then
                            _L.InputBox:SetText("")
                        end
                        if _L.InputBox and _L.InputBox.SetKeyboardFocus then
                            _L.InputBox:SetKeyboardFocus()
                        end
                    else
                        -- Recreate the login UI if the game removed the old widget.
                        _L.InputBusy = false
                        _L.ShowKeyInput(function(key, cancelled)
                            if cancelled or not key or tostring(key) == "" then
                                _G.LicenseSessionKeyConfirmed = false
                                return
                            end
                            _L.CachedKey = tostring(key):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[%r%n%s]+", "")
                            _G.__SHD_LICENSE_KEY = _L.CachedKey
                            _G.LicenseSessionKeyConfirmed = true
                            _G.License_Validate(callback)
                        end)
                    end
                end)
                print("[LICENSE] INVALID - " .. tostring(errorMessage) .. " - login remains locked")
                if callback then callback(false) end
            end
        end, 30)
    end)

    if not postOk then
        _G.LicenseChecking = false
        _L.InputBusy = false
        _L.InputSubmitLocked = false
        _L.ShowPopup("LICENSE ERROR", "Network exception - check internet")
        print("[LICENSE] Exception: " .. tostring(postErr))
        if callback then callback(false) end
    end
end

_G.License_ReadKey = function() return _L.CachedKey or "" end
_G.License_GetHWID = _L.GetHWID
_G.License_API_URL = _L.API_URL

-- ===================================================================================
-- ==================== END ONLINE KEY VERIFICATION ==================================
-- ===================================================================================

-- ========================== ESP & MARKERS ==========================
local distanceMarkerConfig = {
    UIPathName = "/Game/Mod/EvoBase/BluePrints/UIBP/QuickSign/QuickSign_TipHitEnemy_UIBP_New.QuickSign_TipHitEnemy_UIBP_New_C",
    MaxWidgetNum = 99,
    MaxShowDistance = 6000000,
    bBindOutScreen = true,
    bBindBlocked = true,
    bIsBindingActor = true,
    BindSocketName = "head",
    bUseLuaWorldSocketName = true,
    WorldPositionOffset = FVector(0, 0, 50),
    bNeedPreLoad = true,
    Priority = 2
}

local function InitDistanceMarkerSystem()
    pcall(function()
        if InGameMarkTools and InGameMarkTools.ScreenMarkManager and InGameMarkTools.ScreenMarkManager.OnInitMarkGroupData then
            InGameMarkTools.ScreenMarkManager:OnInitMarkGroupData(9999)
        end
        local gameplayTools = require("GameLua.Mod.BaseMod.Common.GamePlayTools")
        local screenMarkConfig = gameplayTools.GetCurrentConfig("ScreenMarkConfig")
        if screenMarkConfig then
            screenMarkConfig[9999] = distanceMarkerConfig
        end
        for moduleName, moduleData in pairs(package.loaded) do
            if type(moduleName) == "string" and string.find(moduleName, "ScreenMarkConfig") then
                if type(moduleData) == "table" then
                    moduleData[9999] = distanceMarkerConfig
                end
            end
        end
    end)
end

if not _G.AK_Active_Marks_Cache then _G.AK_Active_Marks_Cache = {} end

local function createDistanceMarker(enemy)
    if _G._MOD_EXPIRED then return end
    pcall(function()
        if InGameMarkTools and InGameMarkTools.ClientAddMapMark then
            enemy.NativeDistMark = InGameMarkTools.ClientAddMapMark(9999, FVector(0,0,0), 0, "", 4, enemy)
            _G.AK_Active_Marks_Cache[tostring(enemy)] = { actor = enemy, distMark = enemy.NativeDistMark }
        end
    end)
end

local function removeDistanceMarker(enemy)
    pcall(function()
        if InGameMarkTools then
            if InGameMarkTools.ClientRemoveMapMark then
                InGameMarkTools.ClientRemoveMapMark(enemy.NativeDistMark)
            elseif InGameMarkTools.HideMapMark then
                InGameMarkTools.HideMapMark(enemy.NativeDistMark)
            end
        end
        enemy.NativeDistMark = nil
        _G.AK_Active_Marks_Cache[tostring(enemy)] = nil
    end)
end

local function cleanupDeadEnemyMarks()
    for cacheKey, cacheData in pairs(_G.AK_Active_Marks_Cache) do
        local shouldRemove = false
        if not slua.isValid(cacheData.actor) then
            shouldRemove = true
        else
            pcall(function()
                local actor = cacheData.actor
                if actor.bHidden or (actor.Mesh and actor.Mesh.bHidden) then shouldRemove = true end
                if type(actor.IsDead) == "function" and actor:IsDead() then shouldRemove = true
                elseif actor.bIsDead == true or actor.bIsDeadFlag == true then shouldRemove = true end
            end)
        end
        if shouldRemove then
            pcall(function()
                if InGameMarkTools and InGameMarkTools.ClientRemoveMapMark then
                    InGameMarkTools.ClientRemoveMapMark(cacheData.distMark)
                end
            end)
            _G.AK_Active_Marks_Cache[cacheKey] = nil
        end
    end
end

local function processEnemyMapESP(enemy, localPlayer, isMapESPEnabled)
    if _G._MOD_EXPIRED then return end
    if not slua.isValid(enemy) or enemy == localPlayer or enemy.TeamID == localPlayer.TeamID then return end
    local isDead = false
    pcall(function()
        if type(enemy.IsDead) == "function" then isDead = enemy:IsDead()
        elseif enemy.bIsDead then isDead = true end
        if enemy.bHidden or (enemy.Mesh and enemy.Mesh.bHidden) then isDead = true end
    end)
    if not isDead then
        if isMapESPEnabled == 1 then
            if not enemy.bHasAKNativeMapMarker then
                createDistanceMarker(enemy)
                enemy.bHasAKNativeMapMarker = true
            end
        else
            if enemy.bHasAKNativeMapMarker then
                removeDistanceMarker(enemy)
                enemy.bHasAKNativeMapMarker = false
            end
        end
    else
        if enemy.bHasAKNativeMapMarker then
            removeDistanceMarker(enemy)
            enemy.bHasAKNativeMapMarker = false
        end
    end
end

-- ============================================================
-- =============== REDBOX OVERLAY =============================
-- ============================================================
local RedBoxOverlay = {
    bActive = false,
    MainContainer = nil,
    WidgetSlot = nil,
    TextBlockPlayer = nil,
    TextBlockBot = nil,
    Width = 260,
    Height = 25,
    PlayerCount = 0,
    BotCount = 0,
    FontSize = 15,
    TextScaleValue = 1.0,
    NumLayers = 50,
    Red = 0.0,
    Green = 0.0,
    Blue = 0.0,
    LayerAlpha = 0.08,
    _CachedTextPlayer = "",
    _CachedTextBot = "",
    _ParentCanvas = nil,
    _CachedPosVec = nil,
    X_OFFSET = 0,
    Y_POS = 40.0,
    ZOrder = 999,
}

local function RB_GetViewportSize()
    local w, h = 1920, 1080
    pcall(function()
        local WLL = import("WidgetLayoutLibrary")
        local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
        if WLL and WLL.GetViewportSize and slua.isValid(pc) then
            local sz = WLL.GetViewportSize(pc)
            if sz and sz.X and sz.X > 200 then
                w = sz.X
                h = sz.Y
            end
        end
    end)
    return w, h
end

local function RB_InitESPCanvas()
    if RedBoxOverlay._ParentCanvas and slua.isValid(RedBoxOverlay._ParentCanvas) then
        return RedBoxOverlay._ParentCanvas
    end
    local InGameUITools = nil
    pcall(function() InGameUITools = require("GameLua.Mod.BaseMod.Common.UI.InGameUITools") end)
    if not InGameUITools then return nil end
    local MainControlBaseUI = nil
    pcall(function() MainControlBaseUI = InGameUITools.GetMainControlBaseUI() end)
    if not MainControlBaseUI or not Game:IsValid(MainControlBaseUI) then return nil end
    local ParentCanvas = nil
    pcall(function()
        if MainControlBaseUI.CanvasPanel_0 and Game:IsValid(MainControlBaseUI.CanvasPanel_0) then
            ParentCanvas = MainControlBaseUI.CanvasPanel_0
        elseif MainControlBaseUI.CanvasPanel_42 and Game:IsValid(MainControlBaseUI.CanvasPanel_42) then
            ParentCanvas = MainControlBaseUI.CanvasPanel_42
        end
    end)
    if not ParentCanvas then return nil end
    RedBoxOverlay._ParentCanvas = ParentCanvas
    return ParentCanvas
end

function RedBoxOverlay.Create()
    if RedBoxOverlay.MainContainer and slua.isValid(RedBoxOverlay.MainContainer) then return true end

    local ParentCanvas = RB_InitESPCanvas()
    if not ParentCanvas or not slua.isValid(ParentCanvas) then return false end

    local Container = nil
    pcall(function() Container = CGame:NewObjectFromPath("/Script/UMG.CanvasPanel", ParentCanvas) end)
    if not Container or not slua.isValid(Container) then return false end

    local FLinearColor = import("LinearColor") or FLinearColor
    local FVector2D = import("Vector2D") or FVector2D
    local color = FLinearColor(RedBoxOverlay.Red, RedBoxOverlay.Green, RedBoxOverlay.Blue, RedBoxOverlay.LayerAlpha)

    local numLayers = RedBoxOverlay.NumLayers
    local totalWidth = RedBoxOverlay.Width

    for i = 1, numLayers do
        local progress = (i / numLayers) ^ 1.15
        local layerWidth = progress * totalWidth
        local layerX = (totalWidth - layerWidth) / 2.0

        local border = nil
        pcall(function() border = CGame:NewObjectFromPath("/Script/UMG.Border", Container) end)

        if border and slua.isValid(border) then
            pcall(function()
                border:SetBrushColor(color)
                border:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
            end)

            local slot = Container:AddChildToCanvas(border)
            if slot then
                slot:SetPosition(FVector2D(layerX, 0))
                slot:SetSize(FVector2D(layerWidth, RedBoxOverlay.Height))
            end
        end
    end

    local FSlateColor = import("SlateColor") or import("/Script/SlateCore.SlateColor")

    local txtPlayer = nil
    pcall(function() txtPlayer = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Container) end)
    if txtPlayer and slua.isValid(txtPlayer) then
        pcall(function()
            local strText = string.format("Player: %d", RedBoxOverlay.PlayerCount)
            txtPlayer:SetText(strText)
            RedBoxOverlay._CachedTextPlayer = strText

            local redLinear = FLinearColor(1.0, 0.0, 0.0, 1.0)
            if FSlateColor then txtPlayer:SetColorAndOpacity(FSlateColor(redLinear))
            else txtPlayer:SetColorAndOpacity(redLinear) end

            if txtPlayer.Font then
                local font = txtPlayer.Font
                font.Size = RedBoxOverlay.FontSize
                txtPlayer.Font = font
            end
            txtPlayer:SetRenderScale(FVector2D(RedBoxOverlay.TextScaleValue, RedBoxOverlay.TextScaleValue))
            txtPlayer:SetRenderTransformPivot(FVector2D(0.5, 0.5))
            txtPlayer:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        end)
        local txtSlot1 = Container:AddChildToCanvas(txtPlayer)
        if txtSlot1 then
            pcall(function()
                txtSlot1:SetAutoSize(true)
                txtSlot1:SetAlignment(FVector2D(0.5, 0.5))
                txtSlot1:SetPosition(FVector2D(totalWidth * 0.30, RedBoxOverlay.Height * 0.5))
                txtSlot1:SetZOrder(1000)
            end)
        end
        RedBoxOverlay.TextBlockPlayer = txtPlayer
    end

    local txtBot = nil
    pcall(function() txtBot = CGame:NewObjectFromPath("/Script/UMG.TextBlock", Container) end)
    if txtBot and slua.isValid(txtBot) then
        pcall(function()
            local strText = string.format("Bot: %d", RedBoxOverlay.BotCount)
            txtBot:SetText(strText)
            RedBoxOverlay._CachedTextBot = strText

            local greenLinear = FLinearColor(0.0, 1.0, 0.0, 1.0)
            if FSlateColor then txtBot:SetColorAndOpacity(FSlateColor(greenLinear))
            else txtBot:SetColorAndOpacity(greenLinear) end

            if txtBot.Font then
                local font = txtBot.Font
                font.Size = RedBoxOverlay.FontSize
                txtBot.Font = font
            end
            txtBot:SetRenderScale(FVector2D(RedBoxOverlay.TextScaleValue, RedBoxOverlay.TextScaleValue))
            txtBot:SetRenderTransformPivot(FVector2D(0.5, 0.5))
            txtBot:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        end)
        local txtSlot2 = Container:AddChildToCanvas(txtBot)
        if txtSlot2 then
            pcall(function()
                txtSlot2:SetAutoSize(true)
                txtSlot2:SetAlignment(FVector2D(0.5, 0.5))
                txtSlot2:SetPosition(FVector2D(totalWidth * 0.70, RedBoxOverlay.Height * 0.5))
                txtSlot2:SetZOrder(1000)
            end)
        end
        RedBoxOverlay.TextBlockBot = txtBot
    end

    local hud = require("game_frontend_hud")
    if not (hud and hud.AddToContainer) then
        pcall(function() Container:ConditionalBeginDestroy() end)
        return false
    end

    local added = false
    pcall(function()
        hud.AddToContainer(UIContainers.Top, Container, RedBoxOverlay.ZOrder)
        added = true
    end)
    if not added then
        pcall(function() Container:ConditionalBeginDestroy() end)
        return false
    end

    local WidgetLayoutLibrary = import("WidgetLayoutLibrary")
    local MainSlot = nil
    pcall(function() MainSlot = WidgetLayoutLibrary.SlotAsCanvasSlot(Container) end)

    RedBoxOverlay.MainContainer = Container
    RedBoxOverlay.WidgetSlot = MainSlot

    if MainSlot then
        pcall(function()
            MainSlot:SetAnchors(FAnchors(0.5, 0, 0.5, 0))
            MainSlot:SetAlignment(FVector2D(0.5, 0))
            MainSlot:SetPosition(FVector2D(RedBoxOverlay.X_OFFSET, RedBoxOverlay.Y_POS))
            MainSlot:SetSize(FVector2D(RedBoxOverlay.Width, RedBoxOverlay.Height))
        end)
        pcall(function() MainSlot:SetZOrder(RedBoxOverlay.ZOrder) end)
        pcall(function() MainSlot:SetAutoSize(false) end)
    end

    return true
end

function RedBoxOverlay.UpdatePosition()
    local Slot = RedBoxOverlay.WidgetSlot
    if not Slot or not slua.isValid(Slot) then return end

    local FVector2D = import("Vector2D")

    pcall(function()
        Slot:SetAnchors(FAnchors(0.5, 0, 0.5, 0))
        Slot:SetAlignment(FVector2D(0.5, 0))
        Slot:SetPosition(FVector2D(RedBoxOverlay.X_OFFSET or 0, RedBoxOverlay.Y_POS or 40.0))
        Slot:SetSize(FVector2D(RedBoxOverlay.Width or 260, RedBoxOverlay.Height or 25))
    end)
end

function RedBoxOverlay.SetCounts(players, bots)
    if RedBoxOverlay.PlayerCount == players and RedBoxOverlay.BotCount == bots then return end
    RedBoxOverlay.PlayerCount = players or 0
    RedBoxOverlay.BotCount = bots or 0

    if RedBoxOverlay.TextBlockPlayer and slua.isValid(RedBoxOverlay.TextBlockPlayer) then
        pcall(function()
            local strP = string.format("Player: %d", RedBoxOverlay.PlayerCount)
            if RedBoxOverlay._CachedTextPlayer ~= strP then
                RedBoxOverlay.TextBlockPlayer:SetText(strP)
                RedBoxOverlay._CachedTextPlayer = strP
            end
        end)
    end
    if RedBoxOverlay.TextBlockBot and slua.isValid(RedBoxOverlay.TextBlockBot) then
        pcall(function()
            local strB = string.format("Bot: %d", RedBoxOverlay.BotCount)
            if RedBoxOverlay._CachedTextBot ~= strB then
                RedBoxOverlay.TextBlockBot:SetText(strB)
                RedBoxOverlay._CachedTextBot = strB
            end
        end)
    end
end

function RedBoxOverlay.Start()
    if RedBoxOverlay.bActive and RedBoxOverlay.MainContainer and slua.isValid(RedBoxOverlay.MainContainer) then return end
    if RedBoxOverlay.Create() then
        RedBoxOverlay.bActive = true
        pcall(function() RedBoxOverlay.MainContainer:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible) end)
    end
end

function RedBoxOverlay.Stop()
    RedBoxOverlay.bActive = false
    if RedBoxOverlay.MainContainer and slua.isValid(RedBoxOverlay.MainContainer) then
        pcall(function()
            RedBoxOverlay.MainContainer:RemoveFromParent()
            RedBoxOverlay.MainContainer:ConditionalBeginDestroy()
        end)
    end
    RedBoxOverlay.MainContainer = nil
    RedBoxOverlay.WidgetSlot = nil
    RedBoxOverlay.TextBlockPlayer = nil
    RedBoxOverlay.TextBlockBot = nil
    RedBoxOverlay._CachedPosVec = nil
    RedBoxOverlay._ParentCanvas = nil
end

_G.RedBoxOverlay = RedBoxOverlay

_G.RedBoxScanAndUpdate = function()
    if not _G.AK_GetVal("REDBOX_COUNT") or _G.AK_GetVal("REDBOX_COUNT") ~= 1 then
        if RedBoxOverlay.bActive then RedBoxOverlay.Stop() end
        return
    end
    if _G._MOD_EXPIRED then
        if RedBoxOverlay.bActive then RedBoxOverlay.Stop() end
        return
    end
    if not RedBoxOverlay.bActive then
        RedBoxOverlay.Start()
    end

    RedBoxOverlay.UpdatePosition()

    local curTime = os.clock()
    if _G.RedBoxLastScanTime and (curTime - _G.RedBoxLastScanTime) < 0.5 then return end
    _G.RedBoxLastScanTime = curTime

    pcall(function()
        local localPlayer = GameplayData.GetPlayerCharacter()
        if not slua.isValid(localPlayer) then
            RedBoxOverlay.SetCounts(0, 0)
            return
        end

        local allCharacters = {}
        if GameplayData.GetAllPlayerCharacters then
            allCharacters = GameplayData.GetAllPlayerCharacters()
        elseif GameplayData.GameCharacters then
            for _, char in pairs(GameplayData.GameCharacters) do
                table.insert(allCharacters, char)
            end
        end

        local myTeamID = localPlayer.TeamID or (type(localPlayer.GetTeamID) == "function" and localPlayer:GetTeamID()) or -1

        local realPlayers = 0
        local botPlayers = 0

        for _, pawn in pairs(allCharacters) do
            if slua.isValid(pawn) and pawn ~= localPlayer then
                local tTeam = pawn.TeamID or (type(pawn.GetTeamID) == "function" and pawn:GetTeamID()) or -1
                if tTeam ~= myTeamID then
                    local isAlive = false
                    pcall(function()
                        if type(pawn.IsAlive) == "function" then isAlive = pawn:IsAlive()
                        else isAlive = (pawn.Health or 0) > 0 and pawn.HealthStatus ~= 2 end
                        if pawn.bIsDead == true or pawn.HealthStatus == 2 then isAlive = false end
                    end)

                    if isAlive then
                        local isBot = false
                        pcall(function()
                            if pawn.bIsAI == true or pawn.IsAI == true then isBot = true end
                            if type(pawn.IsBot) == "function" and pawn:IsBot() then isBot = true end
                            local pState = pawn.PlayerState
                                or (type(pawn.GetPlayerStateSafety) == "function" and pawn:GetPlayerStateSafety())
                                or (type(pawn.GetPlayerState) == "function" and pawn:GetPlayerState())
                            if slua.isValid(pState) then
                                if pState.bIsABot == true or pState.bIsBot == true then isBot = true end
                                if type(pState.IsBot) == "function" and pState:IsBot() then isBot = true end
                            end
                            if not isBot then
                                local name = pawn.PlayerName
                                    or (type(pawn.GetPlayerNameSafety) == "function" and pawn:GetPlayerNameSafety())
                                    or ""
                                if name ~= "" and (
                                    string.find(name, "Cobra") or
                                    string.find(name, "Target") or
                                    string.find(name, "bot_") or
                                    string.find(name, "b_")
                                ) then isBot = true end
                            end
                        end)

                        if isBot then botPlayers = botPlayers + 1
                        else realPlayers = realPlayers + 1 end
                    end
                end
            end
        end

        RedBoxOverlay.SetCounts(realPlayers, botPlayers)
    end)
end

-- ============================================================
-- ============ SNAPLINE OVERLAY v4 — 120 FPS EDITION =========
-- ============================================================
local SL_FVector2D    = import("Vector2D")
local SL_FLinearColor = import("LinearColor")
local SL_WLL          = import("WidgetLayoutLibrary")
local SL_SBL          = import("SlateBlueprintLibrary")
local SL_RAD2DEG      = 57.29577951308232
local SL_Visible      = UEnums.ESlateVisibility.SelfHitTestInvisible
local SL_Hidden       = UEnums.ESlateVisibility.Collapsed

local SnapLineOverlay = {
    bActive = false,
    _ParentCanvas = nil,
    Thickness   = 1.6,
    OriginY     = 50.0,
    HeadOffsetY = -14.0,
    Color       = {R = 0.9, G = 0.1, B = 0.1, A = 0.9},
    Lerp          = 0.55,
    BoneSampleHz  = 60,
    PosThreshold   = 0.3,
    SizeThreshold  = 1.2,
    AngleThreshold = 0.25,
    Lines          = {},
    _OriginX       = 0,
    _OriginY       = 0,
    _OriginValid   = false,
    _LastViewportW = 0,
    _LastViewportH = 0,
    _ScaleX        = 1.0,
    _ScaleY        = 1.0,
    _OffsetX       = 0.0,
    _OffsetY       = 0.0,
    _TransformValid = false,
    _FrameCount    = 0,
    _FrameSkip     = 3,
}

local function SL_GetCanvas()
    if SnapLineOverlay._ParentCanvas and slua.isValid(SnapLineOverlay._ParentCanvas) then
        return SnapLineOverlay._ParentCanvas
    end
    if _G.RedBoxOverlay and _G.RedBoxOverlay._ParentCanvas and slua.isValid(_G.RedBoxOverlay._ParentCanvas) then
        SnapLineOverlay._ParentCanvas = _G.RedBoxOverlay._ParentCanvas
        return SnapLineOverlay._ParentCanvas
    end
    local canvas = RB_InitESPCanvas()
    if canvas and slua.isValid(canvas) then
        SnapLineOverlay._ParentCanvas = canvas
        return canvas
    end
    return nil
end

local function SL_UpdateCanvasTransform()
    local canvas = SL_GetCanvas()
    if not canvas then SnapLineOverlay._TransformValid = false return false end

    local done = false
    pcall(function()
        if SL_SBL and SL_SBL.AbsoluteToLocal and canvas.GetCachedGeometry then
            local cg = canvas:GetCachedGeometry()
            if cg then
                local pt0 = SL_SBL.AbsoluteToLocal(cg, SL_FVector2D(0, 0))
                local pt1 = SL_SBL.AbsoluteToLocal(cg, SL_FVector2D(100, 100))
                if pt0 and pt1 then
                    SnapLineOverlay._ScaleX  = (pt1.X - pt0.X) / 100
                    SnapLineOverlay._ScaleY  = (pt1.Y - pt0.Y) / 100
                    SnapLineOverlay._OffsetX = pt0.X
                    SnapLineOverlay._OffsetY = pt0.Y
                    SnapLineOverlay._TransformValid = true
                    done = true
                end
            end
        end
    end)

    if not done then
        SnapLineOverlay._ScaleX, SnapLineOverlay._ScaleY = 1.0, 1.0
        SnapLineOverlay._OffsetX, SnapLineOverlay._OffsetY = 0.0, 0.0
        SnapLineOverlay._TransformValid = true
    end
    return true
end

local function SL_PixelToCanvasLocal(px, py)
    return px * SnapLineOverlay._ScaleX + SnapLineOverlay._OffsetX,
           py * SnapLineOverlay._ScaleY + SnapLineOverlay._OffsetY
end

local function SL_RefreshOrigin(force)
    local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
    if not slua.isValid(pc) then return false end

    local screenW, screenH = 1920, 1080
    pcall(function()
        if SL_WLL and SL_WLL.GetViewportSize then
            local sz = SL_WLL.GetViewportSize(pc)
            if sz and sz.X and sz.X > 200 then screenW, screenH = sz.X, sz.Y end
        end
    end)

    if not force
       and SnapLineOverlay._LastViewportW == screenW
       and SnapLineOverlay._LastViewportH == screenH
       and SnapLineOverlay._OriginValid then
        return true
    end

    SnapLineOverlay._LastViewportW = screenW
    SnapLineOverlay._LastViewportH = screenH
    SL_UpdateCanvasTransform()

    SnapLineOverlay._OriginX, SnapLineOverlay._OriginY =
        SL_PixelToCanvasLocal(screenW * 0.5, SnapLineOverlay.OriginY)
    SnapLineOverlay._OriginValid = true
    return true
end

local function SL_CreateLine(keyStr)
    local canvas = SL_GetCanvas()
    if not canvas or not slua.isValid(canvas) then return nil end

    local Border = nil
    pcall(function() Border = CGame:NewObjectFromPath("/Script/UMG.Border", canvas) end)
    if not Border or not slua.isValid(Border) then return nil end

    local color = SL_FLinearColor(SnapLineOverlay.Color.R, SnapLineOverlay.Color.G,
                                  SnapLineOverlay.Color.B, SnapLineOverlay.Color.A)
    pcall(function() Border:SetBrushColor(color) end)
    pcall(function() Border:SetWidgetVisibility(SL_Hidden) end)
    pcall(function() Border:SetRenderTransformPivot(SL_FVector2D(0.0, 0.5)) end)

    local Slot = nil
    pcall(function()
        Slot = canvas:AddChildToCanvas(Border)
        if Slot then
            Slot:SetAutoSize(false)
            Slot:SetZOrder(2)
            Slot:SetAlignment(SL_FVector2D(0.0, 0.5))
        end
    end)
    if not Slot or not slua.isValid(Slot) then return nil end

    local data = {
        Widget = Border,
        Slot   = Slot,
        _curX = 0, _curY = 0,
        _dstX = 0, _dstY = 0,
        _boneX = 0, _boneY = 0,
        _boneValid = false,
        _lastPosX = -99999, _lastPosY = -99999,
        _lastSizeX = -99999, _lastSizeY = -99999,
        _lastAngle = -99999,
        _initialized = false,
        _visible = false,
        _lastPixelX = nil, _lastPixelY = nil,
        _newPixelX  = nil, _newPixelY  = nil,
    }
    SnapLineOverlay.Lines[keyStr] = data
    return data
end

function SnapLineOverlay.UpdateLine(keyStr, pixelX, pixelY, bOnScreen)
    local data = SnapLineOverlay.Lines[keyStr]

    if not bOnScreen or not pixelX then
        if data and data.Widget and slua.isValid(data.Widget) and data._visible then
            pcall(function() data.Widget:SetWidgetVisibility(SL_Hidden) end)
            data._visible = false
            data._initialized = false
            data._boneValid = false
            data._lastPixelX = nil
        end
        return
    end

    if not data then
        data = SL_CreateLine(keyStr)
        if not data then return end
    end

    local Widget, Slot = data.Widget, data.Slot
    if not Widget or not slua.isValid(Widget) or not Slot or not slua.isValid(Slot) then return end

    if pixelX then
        data._newPixelX = pixelX
        data._newPixelY = pixelY
    end

    local targetPixelX = data._newPixelX or pixelX
    local targetPixelY = data._newPixelY or pixelY
    local toX, toY = SL_PixelToCanvasLocal(targetPixelX, targetPixelY + (SnapLineOverlay.HeadOffsetY or 0))

    local lerp = SnapLineOverlay.Lerp or 0.55
    if not data._initialized then
        data._curX, data._curY = toX, toY
        data._initialized = true
    else
        data._curX = data._curX + (toX - data._curX) * lerp
        data._curY = data._curY + (toY - data._curY) * lerp
    end

    local fromX, fromY = SnapLineOverlay._OriginX, SnapLineOverlay._OriginY
    local dx = data._curX - fromX
    local dy = data._curY - fromY
    local length = math.sqrt(dx * dx + dy * dy)

    if length < 2 then
        if data._visible then
            pcall(function() Widget:SetWidgetVisibility(SL_Hidden) end)
            data._visible = false
        end
        return
    end

    if not data._visible then
        pcall(function() Widget:SetWidgetVisibility(SL_Visible) end)
        data._visible = true
    end

    local thickness = SnapLineOverlay.Thickness or 1.5

    if math.abs(data._lastPosX - fromX) > SnapLineOverlay.PosThreshold
       or math.abs(data._lastPosY - fromY) > SnapLineOverlay.PosThreshold then
        pcall(function() Slot:SetPosition(SL_FVector2D(fromX, fromY - thickness * 0.5)) end)
        data._lastPosX, data._lastPosY = fromX, fromY
    end

    if math.abs(data._lastSizeX - length) > SnapLineOverlay.SizeThreshold
       or data._lastSizeY ~= thickness then
        pcall(function() Slot:SetSize(SL_FVector2D(length, thickness)) end)
        data._lastSizeX, data._lastSizeY = length, thickness
    end

    local angle_rad = (math.atan2 and math.atan2(dy, dx)) or math.atan(dy, dx)
    local angle = angle_rad * SL_RAD2DEG
    if math.abs(data._lastAngle - angle) > SnapLineOverlay.AngleThreshold then
        pcall(function() Widget:SetRenderAngle(angle) end)
        data._lastAngle = angle
    end
end

function SnapLineOverlay.RemoveLine(keyStr)
    local data = SnapLineOverlay.Lines[keyStr]
    if data and data.Widget and slua.isValid(data.Widget) then
        pcall(function()
            data.Widget:RemoveFromParent()
            data.Widget:ConditionalBeginDestroy()
        end)
    end
    SnapLineOverlay.Lines[keyStr] = nil
end

function SnapLineOverlay.Stop()
    SnapLineOverlay.bActive = false
    for keyStr, _ in pairs(SnapLineOverlay.Lines) do
        SnapLineOverlay.RemoveLine(keyStr)
    end
    SnapLineOverlay.Lines = {}
    SnapLineOverlay._ParentCanvas = nil
    SnapLineOverlay._OriginValid = false
    SnapLineOverlay._TransformValid = false
end

_G.SnapLineOverlay = SnapLineOverlay

local SL_boneTickCounter = 0

_G.SnapLineScanAndUpdate = function()
    if _G.AK_GetVal("SNAPLINE") ~= 1 then
        if SnapLineOverlay.bActive then SnapLineOverlay.Stop() end
        return
    end
    if _G._MOD_EXPIRED then
        if SnapLineOverlay.bActive then SnapLineOverlay.Stop() end
        return
    end

    SnapLineOverlay.bActive = true
    SnapLineOverlay._FrameCount = SnapLineOverlay._FrameCount + 1
    SL_boneTickCounter = SL_boneTickCounter + 1

    local localPlayer = GameplayData.GetPlayerCharacter()
    if not slua.isValid(localPlayer) then
        for keyStr, _ in pairs(SnapLineOverlay.Lines) do
            SnapLineOverlay.UpdateLine(keyStr, nil, nil, false)
        end
        return
    end

    local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
    if not slua.isValid(pc) then return end
    if not SL_RefreshOrigin() then return end

    local doBoneQuery = (SL_boneTickCounter % (SnapLineOverlay._FrameSkip or 3)) == 0

    local allCharacters = {}
    if GameplayData.GetAllPlayerCharacters then
        allCharacters = GameplayData.GetAllPlayerCharacters()
    elseif GameplayData.GameCharacters then
        for _, char in pairs(GameplayData.GameCharacters) do
            table.insert(allCharacters, char)
        end
    end

    local myTeamID = localPlayer.TeamID or (type(localPlayer.GetTeamID) == "function" and localPlayer:GetTeamID()) or -1
    local activeKeys = {}

    for _, enemy in pairs(allCharacters) do
        if slua.isValid(enemy) and enemy ~= localPlayer then
            local tTeam = enemy.TeamID or (type(enemy.GetTeamID) == "function" and enemy:GetTeamID()) or -1
            if tTeam ~= myTeamID then
                local isAlive = true
                pcall(function()
                    if type(enemy.IsAlive) == "function" then isAlive = enemy:IsAlive()
                    else isAlive = (enemy.Health or 0) > 0 and enemy.HealthStatus ~= 2 end
                    if enemy.bIsDead == true or enemy.HealthStatus == 2 then isAlive = false end
                end)

                if isAlive then
                    local keyStr = tostring(enemy.PlayerKey or enemy)
                    activeKeys[keyStr] = true

                    local headPos = nil
                    if doBoneQuery then
                        pcall(function()
                            if slua.isValid(enemy.Mesh) then
                                if type(enemy.Mesh.GetSocketLocation) == "function" then
                                    headPos = enemy.Mesh:GetSocketLocation("head")
                                elseif type(enemy.Mesh.GetBoneLocation) == "function" then
                                    headPos = enemy.Mesh:GetBoneLocation("head")
                                end
                            end
                        end)
                    end

                    if doBoneQuery and not headPos then
                        pcall(function()
                            if type(enemy.K2_GetActorLocation) == "function" then
                                headPos = enemy:K2_GetActorLocation()
                                if headPos then headPos.Z = headPos.Z + 70 end
                            end
                        end)
                    end

                    if headPos then
                        local screen = SL_FVector2D(0, 0)
                        local ok = false
                        pcall(function() ok = pc:ProjectWorldLocationToScreen(headPos, screen, false) end)
                        if ok and screen and screen.X ~= 0 and screen.Y ~= 0 then
                            SnapLineOverlay.UpdateLine(keyStr, screen.X, screen.Y, true)
                        else
                            SnapLineOverlay.UpdateLine(keyStr, nil, nil, false)
                        end
                    else
                        local data = SnapLineOverlay.Lines[keyStr]
                        if data and data._visible and data._newPixelX then
                            SnapLineOverlay.UpdateLine(keyStr, data._newPixelX, data._newPixelY, true)
                        end
                    end
                else
                    local keyStr = tostring(enemy.PlayerKey or enemy)
                    SnapLineOverlay.RemoveLine(keyStr)
                end
            end
        end
    end

    for keyStr, _ in pairs(SnapLineOverlay.Lines) do
        if not activeKeys[keyStr] then
            SnapLineOverlay.RemoveLine(keyStr)
        end
    end
end

_G.StartSnapLineFastLoop = function()
    if _G.SnapLineTimerHandle then return end
    local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
    if not slua.isValid(pc) or not pc.AddGameTimer then return end

    _G.SnapLineTimerHandle = pc:AddGameTimer(0.00833, true, function()
        if _G.AK_GetVal("SNAPLINE") ~= 1 then return end
        pcall(_G.SnapLineScanAndUpdate)
    end)
end

_G.StopSnapLineFastLoop = function()
    if _G.SnapLineTimerHandle then
        local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
        if slua.isValid(pc) and pc.RemoveGameTimer then
            pc:RemoveGameTimer(_G.SnapLineTimerHandle)
        end
        _G.SnapLineTimerHandle = nil
    end
end

-- ========================== AIMBOT ==========================
function ApplyHardAimbot()
    if not (_G.IsLicenseOK and _G.IsLicenseOK()) then return end
    pcall(function()
        local pc = slua_GameFrontendHUD:GetPlayerController()
        if not slua.isValid(pc) then return end
        local char = pc:GetPlayerCharacterSafety()
        if not slua.isValid(char) then return end
        local wm = char.WeaponManagerComponent
        if not slua.isValid(wm) then return end
        local weapon = wm.CurrentWeaponReplicated
        if not slua.isValid(weapon) then return end
        local entity = weapon.ShootWeaponEntityComp
        if not slua.isValid(entity) then return end
        entity.RecoilKickADS = 0.01
        entity.GameDeviationFactor = 0.01
        entity.GameDeviationAccuracy = 0.01
        if entity.AutoAimingConfig then
            for _, range in ipairs({"OuterRange", "InnerRange"}) do
                local cfg = entity.AutoAimingConfig[range]
                if cfg then
                    cfg.Speed = 3.0; cfg.RangeRate = 2.0; cfg.SpeedRate = 3.0; cfg.RangeRateSight = 2.0; cfg.SpeedRateSight = 3.0
                    cfg.CrouchRate = 2.5; cfg.ProneRate = 3.0; cfg.DyingRate = 0
                    cfg.adsorbMaxRange = 200; cfg.adsorbMinRange = 20; cfg.adsorbMinAttenuationDis = 100; cfg.adsorbMaxAttenuationDis = 8000; cfg.adsorbActiveMinRange = 20
                end
            end
            entity.AutoAimingConfig = entity.AutoAimingConfig
        end
        pcall(function()
            local aimComp = char.BP_AutoAimingComponent_C or char.BP_AutoAimingComponent or char.AutoAimingComponent
            if slua.isValid(aimComp) and aimComp.Bones then
                pcall(function() aimComp.Bones[0] = "neck_01" end)
                pcall(function() aimComp.Bones[1] = "neck_01" end)
                pcall(function() aimComp.Bones[2] = "neck_01" end)
                pcall(function() aimComp.Bones:Set(0, "neck_01") end)
                pcall(function() aimComp.Bones:Set(1, "neck_01") end)
                pcall(function() aimComp.Bones:Set(2, "neck_01") end)
            end
        end)
    end)
end

_G.GTLMODConfig = _G.GTLMODConfig or {
    AimTouchEnable = false,
    AimTouchHipIgKnock = true,
    AimTouchHipIgBot = true,
    AimTouchSGIgKnock = true,
    AimTouchSGIgBot = true,
    AimTouchHipVisCheck = true,
    AimTouchSGVisCheck = true,
    AimTouchHipfire = false,
    AimTouchSG = false,
    AimTouchSGAutoFire = false,
    AimTouchScopeAll = false,
    AimTouchScopeIgKnock = true,
    AimTouchScopeIgBot = true,
    AimTouchScopeVisCheck = true,
    AimTouchScopeSniper = false,
    AimTouchSniperIgKnock = true,
    AimTouchSniperIgBot = true,
    AimTouchSniperVisCheck = true,
    CustomMagicBullet = false,
    BlackSky = false,
    RemoveFog = false,
    UnlockFPS = false,
}

_G.GTLMODState = _G.GTLMODState or {
    CustomTextData = {
        IpadViewFOV = 120,
        AimTouchHipPrio = 1, AimTouchHipBone = 1, AimTouchHipCond = 1, AimTouchHipSpeed = 50,
        AimTouchHipFOV = 30, AimTouchHipDist = 250,
        AimTouchScopePrio = 1, AimTouchScopeBone = 2, AimTouchScopeCond = 1, AimTouchScopeSpeed = 40,
        AimTouchScopeFOV = 20, AimTouchScopeDist = 300, AimTouchScopePred = 0, AimTouchScopeRecoil = 0,
        AimTouchSniperPrio = 1, AimTouchSniperBone = 1, AimTouchSniperCond = 2, AimTouchSniperSpeed = 30,
        AimTouchSniperFOV = 20, AimTouchSniperDist = 400, AimTouchSniperPred = 0,
        AimTouchSGCond = 1, AimTouchSGPrio = 1, AimTouchSGBone = 2, AimTouchSGSpeed = 80,
        AimTouchSGFOV = 40, AimTouchSGDist = 30,
        MagicHead = 1.0,
        MagicBody = 1.0,
        MagicLegs = 1.0,
    },
    AimbotLoopToken = 0,
    IsAutoFiring = false,
    MagicUpdateVersion = 1,
    LastMagicConfigHash = "",
}

-- MAGIC BULLET: caches
_G.AK_OrigHitboxes     = _G.AK_OrigHitboxes     or {}
_G.AK_ModdedPhysAssets = _G.AK_ModdedPhysAssets or {}

-- ============================================================
-- ===== MAGIC BULLET: BaseDamage MULTIPLIER (WEAPON ENTITY) =====
-- ============================================================
_G.ApplyMagicBullet = function()
    if not _G.GTLMODConfig.CustomMagicBullet then return end
    pcall(function()
        local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
        if not slua.isValid(pc) then return end
        local char = pc:GetPlayerCharacterSafety()
        if not slua.isValid(char) then return end
        local wm = char.WeaponManagerComponent
        if not slua.isValid(wm) then return end
        local weapon = wm.CurrentWeaponReplicated
        if not slua.isValid(weapon) then return end

        local mHead = _G.GTLMODState.CustomTextData.MagicHead or 1.0

        local entities = {}
        if slua.isValid(weapon.ShootWeaponEntityComp) then table.insert(entities, weapon.ShootWeaponEntityComp) end
        if slua.isValid(weapon.ShootWeaponEntity) then table.insert(entities, weapon.ShootWeaponEntity) end
        if slua.isValid(weapon.ShootWeaponEntity_GEN_VARIABLE) then table.insert(entities, weapon.ShootWeaponEntity_GEN_VARIABLE) end
        if slua.isValid(weapon.ShootWeaponComponent) and slua.isValid(weapon.ShootWeaponComponent.ShootWeaponEntityComponent) then
            table.insert(entities, weapon.ShootWeaponComponent.ShootWeaponEntityComponent)
        end

        for _, entity in ipairs(entities) do
            if slua.isValid(entity) then
                if not entity.__MB_OrigBaseDamage then
                    entity.__MB_OrigBaseDamage = entity.BaseDamage or 0
                end
                entity.BaseDamage = entity.__MB_OrigBaseDamage * mHead
            end
        end
    end)
end

-- ============================================================
-- ===== MAGIC BULLET: HITBOX (PHYSICS ASSET) SCALER ==========
-- ============================================================
local function GetFirstElemSafe(elemArray)
    if elemArray and type(elemArray.Num) == "function" and elemArray:Num() > 0 then
        if type(elemArray.Get) == "function" then return elemArray:Get(0) end
    elseif elemArray and type(elemArray) == "table" and #elemArray > 0 then
        return elemArray[1]
    end
    return nil
end

_G.ApplyMagicBulletHitbox = function(enemy, mHead, mBody, mLegs, runInject)
    if not slua.isValid(enemy) then return end
    pcall(function()
        local eMesh = enemy.Mesh
        if not slua.isValid(eMesh) then return end

        local uniqueID = type(enemy.GetUniqueID) == "function" and enemy:GetUniqueID() or tostring(enemy.PlayerKey or enemy)

        if enemy.__MB_Hash == _G.GTLMODState.LastMagicConfigHash and enemy.__MB_TargetID == uniqueID then
            return
        end

        local PhysicsAsset = eMesh.PhysicsAssetOverride
        if not slua.isValid(PhysicsAsset) and eMesh.SkeletalMesh then
            PhysicsAsset = eMesh.SkeletalMesh.PhysicsAsset
        end
        if not slua.isValid(PhysicsAsset) or not PhysicsAsset.SkeletalBodySetups then return end

        local PhysAssetName = "DefaultPhys"
        pcall(function() PhysAssetName = PhysicsAsset:GetName() end)

        if _G.AK_ModdedPhysAssets[PhysAssetName] == _G.GTLMODState.LastMagicConfigHash then
            if eMesh.SetPhysicsAsset then eMesh:SetPhysicsAsset(PhysicsAsset) end
            eMesh.PhysicsAssetOverride = PhysicsAsset
            enemy.__MB_Hash = _G.GTLMODState.LastMagicConfigHash
            enemy.__MB_TargetID = uniqueID
            return
        end

        if not _G.AK_OrigHitboxes[PhysAssetName] then _G.AK_OrigHitboxes[PhysAssetName] = {} end
        local OrigHitboxData = _G.AK_OrigHitboxes[PhysAssetName]

        local BoneScaleMap = {
            ["head"]     = mHead, ["neck_01"]  = mHead,
            ["pelvis"]   = mBody, ["spine_01"] = mBody, ["spine_02"] = mBody, ["spine_03"] = mBody,
            ["thigh_l"]  = mLegs, ["thigh_r"]  = mLegs,
            ["calf_l"]   = mLegs, ["calf_r"]   = mLegs,
            ["foot_l"]   = mLegs, ["foot_r"]   = mLegs,
        }

        local SkeletalBodySetups = PhysicsAsset.SkeletalBodySetups
        local numSetups = type(SkeletalBodySetups.Num) == "function" and SkeletalBodySetups:Num() or #SkeletalBodySetups
        local limit = numSetups > 50 and 50 or numSetups

        for i = 1, limit do
            local BodySetup = type(SkeletalBodySetups.Get) == "function" and SkeletalBodySetups:Get(i-1) or SkeletalBodySetups[i]
            if slua.isValid(BodySetup) then
                local LowerBoneName = string.lower(tostring(BodySetup.BoneName))
                local MatchedBoneKey = nil
                for k, _ in pairs(BoneScaleMap) do
                    if string.find(LowerBoneName, k, 1, true) then MatchedBoneKey = k break end
                end

                if MatchedBoneKey then
                    local TargetScale = 1.0
                    if runInject then TargetScale = BoneScaleMap[MatchedBoneKey] end

                    local AggGeom = BodySetup.AggGeom
                    local BoxElems    = AggGeom and AggGeom.BoxElems    or BodySetup.BoxElems
                    local SphereElems = AggGeom and AggGeom.SphereElems or BodySetup.SphereElems
                    local SphylElems  = AggGeom and AggGeom.SphylElems  or BodySetup.SphylElems

                    local BoxElem    = GetFirstElemSafe(BoxElems)
                    local SphereElem = GetFirstElemSafe(SphereElems)
                    local SphylElem  = GetFirstElemSafe(SphylElems)

                    if not OrigHitboxData[MatchedBoneKey] then
                        OrigHitboxData[MatchedBoneKey] = { Box = nil, Sphere = nil, Sphyl = nil }
                        if BoxElem then OrigHitboxData[MatchedBoneKey].Box = { X = BoxElem.X, Y = BoxElem.Y, Z = BoxElem.Z } end
                        if SphereElem then OrigHitboxData[MatchedBoneKey].Sphere = { Radius = SphereElem.Radius } end
                        if SphylElem then OrigHitboxData[MatchedBoneKey].Sphyl = { Radius = SphylElem.Radius, Length = SphylElem.Length } end
                    end

                    local OrigElemData = OrigHitboxData[MatchedBoneKey]

                    if OrigElemData.Box and BoxElem then
                        BoxElem.X = OrigElemData.Box.X * TargetScale
                        BoxElem.Y = OrigElemData.Box.Y * TargetScale
                        BoxElem.Z = OrigElemData.Box.Z * TargetScale
                        if type(BoxElems.Set) == "function" then BoxElems:Set(0, BoxElem) else BoxElems[1] = BoxElem end
                        if AggGeom then AggGeom.BoxElems = BoxElems; BodySetup.AggGeom = AggGeom else BodySetup.BoxElems = BoxElems end
                    end

                    if OrigElemData.Sphere and SphereElem then
                        SphereElem.Radius = OrigElemData.Sphere.Radius * TargetScale
                        if type(SphereElems.Set) == "function" then SphereElems:Set(0, SphereElem) else SphereElems[1] = SphereElem end
                        if AggGeom then AggGeom.SphereElems = SphereElems; BodySetup.AggGeom = AggGeom else BodySetup.SphereElems = SphereElems end
                    end

                    if OrigElemData.Sphyl and SphylElem then
                        SphylElem.Radius = OrigElemData.Sphyl.Radius * TargetScale
                        SphylElem.Length = OrigElemData.Sphyl.Length * TargetScale
                        if type(SphylElems.Set) == "function" then SphylElems:Set(0, SphylElem) else SphylElems[1] = SphylElem end
                        if AggGeom then AggGeom.SphylElems = SphylElems; BodySetup.AggGeom = AggGeom else BodySetup.SphylElems = SphylElems end
                    end
                end
            end
        end

        _G.AK_ModdedPhysAssets[PhysAssetName] = _G.GTLMODState.LastMagicConfigHash

        if eMesh.SetPhysicsAsset then eMesh:SetPhysicsAsset(PhysicsAsset) end
        eMesh.PhysicsAssetOverride = PhysicsAsset

        enemy.__MB_Hash = _G.GTLMODState.LastMagicConfigHash
        enemy.__MB_TargetID = uniqueID
    end)
end

local function UpdateMagicBulletHash()
    local mHead, mBody, mLegs = 1.0, 1.0, 1.0
    local runInject = false
    if _G.GTLMODConfig.CustomMagicBullet then
        runInject = true
        local c = _G.GTLMODState.CustomTextData
        mHead = tonumber(c.MagicHead) or 1.0
        mBody = tonumber(c.MagicBody) or 1.0
        mLegs = tonumber(c.MagicLegs) or 1.0
    end
    if runInject then
        local newHash = string.format("M_%.3f_%.3f_%.3f", mHead, mBody, mLegs)
        if _G.GTLMODState.LastMagicConfigHash ~= newHash then
            _G.GTLMODState.MagicUpdateVersion = (_G.GTLMODState.MagicUpdateVersion or 0) + 1
            _G.GTLMODState.LastMagicConfigHash = newHash
        end
    else
        if _G.GTLMODState.LastMagicConfigHash ~= "OFF" then
            _G.GTLMODState.MagicUpdateVersion = (_G.GTLMODState.MagicUpdateVersion or 0) + 1
            _G.GTLMODState.LastMagicConfigHash = "OFF"
        end
    end
    return mHead, mBody, mLegs, runInject
end

_G.UpdateMagicBulletHash = UpdateMagicBulletHash

-- ========================== AIMTOUCH ==========================
_G.GetEnemyTargetsFromActors = function(radius)
    local result = {}
    local player = GameplayData.GetPlayerCharacter()
    if not slua.isValid(player) then return result end
    local allCharacters = {}
    if GameplayData.GetAllPlayerCharacters then
        allCharacters = GameplayData.GetAllPlayerCharacters()
    elseif GameplayData.GameCharacters then
        for _, char in pairs(GameplayData.GameCharacters) do table.insert(allCharacters, char) end
    end
    local myTeam = player:GetTeamID()
    for _, actor in pairs(allCharacters) do
        if slua.isValid(actor) and actor ~= player and actor.GetTeamID and actor:IsAlive() then
            if actor:GetTeamID() ~= myTeam then
                local dist = player:GetDistanceTo(actor)
                if dist <= radius then
                    table.insert(result, actor)
                end
            end
        end
    end
    return result
end

_G.AimTouch = function()
    pcall(function()
        if not _G.GTLMODConfig.AimTouchEnable then return end
        local player = GameplayData.GetPlayerCharacter()
        if not slua.isValid(player) then return end
        local pc = player:GetPlayerControllerSafety()
        if not slua.isValid(pc) then return end
        local isFiring = player.bIsWeaponFiring
        local isADS = player.bIsGunADS
        local weapon = player.WeaponManagerComponent and player.WeaponManagerComponent.CurrentWeaponReplicated
        if not weapon and type(player.GetCurrentShootWeapon) == "function" then
            weapon = player:GetCurrentShootWeapon()
        end
        local isShotgun = false
        local isSniper = false
        local currentAmmo = 1
        if slua.isValid(weapon) then
            local wID = type(weapon.GetWeaponID) == "function" and weapon:GetWeaponID() or 0
            local wName = type(weapon.GetWeaponName) == "function" and weapon:GetWeaponName() or ""
            if (wID >= 1030000 and wID < 1040000) or wName:find("S686") or wName:find("S1897") or wName:find("S12") or wName:find("DBS") or wName:find("M1014") then 
                isShotgun = true 
            end
            if wName:find("Kar98") or wName:find("M24") or wName:find("AWM") or wName:find("Mosin") or wName:find("Win94") or wName:find("AMR") or wName:find("SKS") or wName:find("SLR") or wName:find("Mini") or wName:find("Mk14") or wName:find("QBU") or wName:find("Mk12") or wName:find("VSS") then
                isSniper = true
            end
            if type(weapon.GetCurrentAmmo) == "function" then
                currentAmmo = weapon:GetCurrentAmmo()
            elseif weapon.ShootWeaponComponent and type(weapon.ShootWeaponComponent.GetCurrentAmmo) == "function" then
                currentAmmo = weapon.ShootWeaponComponent:GetCurrentAmmo()
            elseif weapon.CurrentAmmo ~= nil then
                currentAmmo = weapon.CurrentAmmo
            end
        end
        if _G.GTLMODState.IsAutoFiring then
            pcall(function()
                player.bIsWeaponFiring = false
                if type(player.SetIsWeaponFiring) == "function" then player:SetIsWeaponFiring(false) end
                if slua.isValid(pc) and type(pc.SetIsWeaponFiring) == "function" then pc:SetIsWeaponFiring(false) end
                local wepMgr = player.WeaponManagerComponent
                if slua.isValid(wepMgr) then wepMgr.bIsWeaponFiring = false end
            end)
            _G.GTLMODState.IsAutoFiring = false
        end
        if isShotgun and currentAmmo <= 0 then return end
        local cond = 2
        local prioMode = 1
        local boneIdx = 1
        local speedVal = 50
        local fovVal = 30
        local maxDistMeters = 50
        local useVisCheck = false
        local igKnock = false
        local igBot = false
        local predVal = 0 
        local recoilCompVal = 0 
        if isShotgun and _G.GTLMODConfig.AimTouchSG then
            cond = _G.GTLMODState.CustomTextData.AimTouchSGCond or 1
            if _G.GTLMODConfig.AimTouchSGAutoFire then cond = 2 end
            if cond == 1 and not isFiring then return end
            prioMode = _G.GTLMODState.CustomTextData.AimTouchSGPrio or 1
            boneIdx = _G.GTLMODState.CustomTextData.AimTouchSGBone or 2
            speedVal = _G.GTLMODState.CustomTextData.AimTouchSGSpeed or 80
            fovVal = _G.GTLMODState.CustomTextData.AimTouchSGFOV or 40
            maxDistMeters = _G.GTLMODState.CustomTextData.AimTouchSGDist or 30
            useVisCheck = _G.GTLMODConfig.AimTouchSGVisCheck
            igKnock = _G.GTLMODConfig.AimTouchSGIgKnock
            igBot = _G.GTLMODConfig.AimTouchSGIgBot
        elseif isADS then
            if isSniper and _G.GTLMODConfig.AimTouchScopeSniper then
                cond = _G.GTLMODState.CustomTextData.AimTouchSniperCond or 2
                if cond == 1 and not isFiring then return end
                prioMode = _G.GTLMODState.CustomTextData.AimTouchSniperPrio or 1
                boneIdx = _G.GTLMODState.CustomTextData.AimTouchSniperBone or 1
                speedVal = _G.GTLMODState.CustomTextData.AimTouchSniperSpeed or 30
                fovVal = _G.GTLMODState.CustomTextData.AimTouchSniperFOV or 20
                maxDistMeters = _G.GTLMODState.CustomTextData.AimTouchSniperDist or 400
                useVisCheck = _G.GTLMODConfig.AimTouchSniperVisCheck
                igKnock = _G.GTLMODConfig.AimTouchSniperIgKnock
                igBot = _G.GTLMODConfig.AimTouchSniperIgBot
                predVal = _G.GTLMODState.CustomTextData.AimTouchSniperPred or 0
            elseif _G.GTLMODConfig.AimTouchScopeAll then
                cond = _G.GTLMODState.CustomTextData.AimTouchScopeCond or 1
                if cond == 1 and not isFiring then return end
                prioMode = _G.GTLMODState.CustomTextData.AimTouchScopePrio or 1
                boneIdx = _G.GTLMODState.CustomTextData.AimTouchScopeBone or 2
                speedVal = _G.GTLMODState.CustomTextData.AimTouchScopeSpeed or 40
                fovVal = _G.GTLMODState.CustomTextData.AimTouchScopeFOV or 20
                maxDistMeters = _G.GTLMODState.CustomTextData.AimTouchScopeDist or 300
                useVisCheck = _G.GTLMODConfig.AimTouchScopeVisCheck
                igKnock = _G.GTLMODConfig.AimTouchScopeIgKnock
                igBot = _G.GTLMODConfig.AimTouchScopeIgBot
                predVal = _G.GTLMODState.CustomTextData.AimTouchScopePred or 0
                recoilCompVal = _G.GTLMODState.CustomTextData.AimTouchScopeRecoil or 0
            else
                return
            end
        else
            if not _G.GTLMODConfig.AimTouchHipfire then return end
            cond = _G.GTLMODState.CustomTextData.AimTouchHipCond or 1
            if cond == 1 and not isFiring then return end 
            prioMode = _G.GTLMODState.CustomTextData.AimTouchHipPrio or 1
            boneIdx = _G.GTLMODState.CustomTextData.AimTouchHipBone or 1
            speedVal = _G.GTLMODState.CustomTextData.AimTouchHipSpeed or 50
            fovVal = _G.GTLMODState.CustomTextData.AimTouchHipFOV or 30
            maxDistMeters = _G.GTLMODState.CustomTextData.AimTouchHipDist or 250
            useVisCheck = _G.GTLMODConfig.AimTouchHipVisCheck
            igKnock = _G.GTLMODConfig.AimTouchHipIgKnock
            igBot = _G.GTLMODConfig.AimTouchHipIgBot
        end
        local currentMaxDist = maxDistMeters * 100 
        local enemies = _G.GetEnemyTargetsFromActors(currentMaxDist)
        if not enemies or #enemies == 0 then return end
        local FVector2D = import("Vector2D")
        local UGameplayStatics = import("GameplayStatics")
        local KismetMathLibrary = import("KismetMathLibrary")
        local camManager = UGameplayStatics.GetPlayerCameraManager(pc, 0)
        if not slua.isValid(camManager) then return end
        local camLoc = camManager:GetCameraLocation()
        if not camLoc then return end
        local ui_util = require("client.common.ui_util")
        if not ui_util then return end
        local viewportSize = ui_util.GetViewportSize()
        if not viewportSize then return end
        local centerX = viewportSize.X * 0.5
        local centerY = viewportSize.Y * 0.5
        local FOV_RADIUS = (fovVal / 100.0) * (viewportSize.X / 2.0)
        local bestTarget = nil
        local bestScore = 99999999 
        local selBoneName = "head"
        if boneIdx == 1 then selBoneName = "head"
        elseif boneIdx == 2 then selBoneName = "spine_03"
        elseif boneIdx == 3 then selBoneName = "spine_01"
        elseif boneIdx == 4 then selBoneName = "pelvis" end
        for i, target in ipairs(enemies) do
            if not slua.isValid(target) then goto continue end
            pcall(function()
                if slua.isValid(target.Mesh) then
                    target.Mesh.MeshComponentUpdateFlag = 0
                end
            end)
            if igKnock and target.HealthStatus == 1 then goto continue end
            if igBot then
                local tIsBot = false
                if target.bIsAI == true or target.IsAI == true then tIsBot = true end
                local pState = target.PlayerState
                if slua.isValid(pState) and (pState.bIsABot or pState.bIsBot) then tIsBot = true end
                if tIsBot then goto continue end
            end
            if useVisCheck then
                local curTime = os.clock()
                local tId = type(target.GetUniqueID) == "function" and target:GetUniqueID() or tostring(target)
                _G.AimTouchVisCache = _G.AimTouchVisCache or {}
                if not _G.AimTouchVisCache[tId] or (curTime - _G.AimTouchVisCache[tId].time) > 0.2 then
                    local isHidden = true
                    pcall(function() if pc:LineOfSightTo(target) then isHidden = false end end)
                    _G.AimTouchVisCache[tId] = { hidden = isHidden, time = curTime }
                end
                if _G.AimTouchVisCache[tId].hidden then goto continue end
            end
            local tPos = target:GetBonePos(selBoneName, {X=0, Y=0, Z=0})
            if not tPos or (tPos.X == 0 and tPos.Y == 0 and tPos.Z == 0) then
                if type(target.GetSocketLocation) == "function" then
                    tPos = target:GetSocketLocation(selBoneName)
                end
            end
            if not tPos or (tPos.X == 0 and tPos.Y == 0 and tPos.Z == 0) then
                if type(target.K2_GetActorLocation) == "function" then
                    tPos = target:K2_GetActorLocation()
                    if tPos then
                        if boneIdx == 1 then tPos.Z = tPos.Z + 70
                        elseif boneIdx == 2 then tPos.Z = tPos.Z + 40
                        elseif boneIdx == 3 then tPos.Z = tPos.Z + 20 end
                    end
                end
            end
            if not tPos or (tPos.X == 0 and tPos.Y == 0 and tPos.Z == 0) then goto continue end
            local screen = FVector2D()
            local success = pc:ProjectWorldLocationToScreen(tPos, screen, false)
            if not success or screen.X <= 0 or screen.Y <= 0 then goto continue end
            local dx = screen.X - centerX
            local dy = screen.Y - centerY
            local distScreen = math.sqrt(dx*dx + dy*dy)
            if distScreen > FOV_RADIUS then goto continue end
            local currentScore = distScreen
            if prioMode == 2 then currentScore = player:GetDistanceTo(target)
            elseif prioMode == 3 then currentScore = target.Health or 100
            elseif prioMode == 4 then 
                local hp = target.Health or 100
                local maxhp = target.HealthMax or 100
                if maxhp <= 0 then maxhp = 100 end
                currentScore = hp / maxhp
            end
            if currentScore < bestScore then
                bestScore = currentScore
                bestTarget = target
            end
            ::continue::
        end
        if not slua.isValid(bestTarget) then return end
        local finalBonePos = bestTarget:GetBonePos(selBoneName, {X=0, Y=0, Z=0})
        if not finalBonePos or (finalBonePos.X == 0 and finalBonePos.Y == 0 and finalBonePos.Z == 0) then
            if type(bestTarget.GetSocketLocation) == "function" then
                finalBonePos = bestTarget:GetSocketLocation(selBoneName)
            end
        end
        if not finalBonePos or (finalBonePos.X == 0 and finalBonePos.Y == 0 and finalBonePos.Z == 0) then
            if type(bestTarget.K2_GetActorLocation) == "function" then
                finalBonePos = bestTarget:K2_GetActorLocation()
                if finalBonePos then
                    if boneIdx == 1 then finalBonePos.Z = finalBonePos.Z + 70
                    elseif boneIdx == 2 then finalBonePos.Z = finalBonePos.Z + 40
                    elseif boneIdx == 3 then finalBonePos.Z = finalBonePos.Z + 20 end
                end
            end
        end
        if not finalBonePos or (finalBonePos.X == 0 and finalBonePos.Y == 0 and finalBonePos.Z == 0) then return end
        if predVal > 0 then
            pcall(function()
                local tVelocity = nil
                if type(bestTarget.GetVelocity) == "function" then tVelocity = bestTarget:GetVelocity() end
                if tVelocity and (tVelocity.X ~= 0 or tVelocity.Y ~= 0) then
                    local distToEnemy = player:GetDistanceTo(bestTarget) / 100.0
                    local ToF = (distToEnemy / 800.0) * (predVal / 50.0) 
                    finalBonePos.X = finalBonePos.X + (tVelocity.X * ToF)
                    finalBonePos.Y = finalBonePos.Y + (tVelocity.Y * ToF)
                end
            end)
        end
        local rot = KismetMathLibrary.FindLookAtRotation(camLoc, finalBonePos)
        if not rot then return end
        local currentRot = pc:GetControlRotation()
        if not currentRot then return end
        local deltaYaw = rot.Yaw - currentRot.Yaw
        local deltaPitch = rot.Pitch - currentRot.Pitch
        if isADS then
            local camRot = nil
            if type(camManager.GetCameraRotation) == "function" then camRot = camManager:GetCameraRotation() end
            if camRot then
                deltaYaw = deltaYaw - (camRot.Yaw - currentRot.Yaw)
                deltaPitch = deltaPitch - (camRot.Pitch - currentRot.Pitch)
            end
        end
        if deltaYaw > 180 then deltaYaw = deltaYaw - 360 end
        if deltaYaw < -180 then deltaYaw = deltaYaw + 360 end
        if deltaPitch > 180 then deltaPitch = deltaPitch - 360 end
        if deltaPitch < -180 then deltaPitch = deltaPitch + 360 end

        local smoothFactor = 0.0
        if speedVal >= 100 then smoothFactor = 1.0
        else
            smoothFactor = math.min(1.0, speedVal / 100.0)
            if smoothFactor < 0.05 then smoothFactor = 0.05 end
        end

        local finalPitch = currentRot.Pitch + (deltaPitch * smoothFactor)
        local finalYaw = currentRot.Yaw + (deltaYaw * smoothFactor)
        if recoilCompVal > 0 and isFiring then
            local pullDownForce = (recoilCompVal / 50.0) * 1.5
            finalPitch = finalPitch - pullDownForce
        end
        local finalRot = { Pitch = finalPitch, Yaw = finalYaw, Roll = 0 }
        pc:SetControlRotation(finalRot, "AimTouch")
        if isShotgun and _G.GTLMODConfig.AimTouchSGAutoFire then
            pcall(function()
                local distToTarget = player:GetDistanceTo(bestTarget) / 100
                if distToTarget <= maxDistMeters then
                    player.bIsWeaponFiring = true
                    if type(player.SetIsWeaponFiring) == "function" then player:SetIsWeaponFiring(true) end
                    if slua.isValid(pc) and type(pc.SetIsWeaponFiring) == "function" then pc:SetIsWeaponFiring(true) end
                    local wepMgr = player.WeaponManagerComponent
                    if slua.isValid(wepMgr) then wepMgr.bIsWeaponFiring = true end
                    local currentWep = player:GetCurrentWeapon()
                    if slua.isValid(currentWep) and type(currentWep.StartFire) == "function" then currentWep:StartFire() end
                    _G.GTLMODState.IsAutoFiring = true
                end
            end)
        end
    end)
end

function _G.StartAimTouchLoop()
    if _G.AimTouchTimerHandle then return end
    local timerFunc = function()
        if _G.GTLMODConfig.AimTouchEnable then
            pcall(_G.AimTouch)
        end
    end
    if Game and Game.AddGameTimer then
        _G.AimTouchTimerHandle = Game:AddGameTimer(0.03, true, timerFunc)
    else
        local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
        if slua.isValid(pc) and pc.AddGameTimer then
            _G.AimTouchTimerHandle = pc:AddGameTimer(0.03, true, timerFunc)
        end
    end
end

function _G.StopAimTouchLoop()
    if _G.AimTouchTimerHandle then
        if Game and Game.RemoveGameTimer then
            Game:RemoveGameTimer(_G.AimTouchTimerHandle)
        else
            local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
            if slua.isValid(pc) and pc.RemoveGameTimer then
                pc:RemoveGameTimer(_G.AimTouchTimerHandle)
            end
        end
        _G.AimTouchTimerHandle = nil
    end
end

-- ========================== WALLHACK ==========================
local LinearColor = import("LinearColor")
local CONSOLE_READY = false
local PROCESSED_PAWNS = {}
local TICK_COUNT = 0
_G.WH_TIMER = _G.WH_TIMER or nil
local TICK_INTERVAL = 1.0
local MAX_PAWNS_PER_TICK = 5
local RESET_PROCESSED_EVERY = 12
local AVATAR_SLOTS = {0,1,2,3,4,5,6,7}

local colors = {
    vis = LinearColor(0, 255, 0, 100),
    occ = LinearColor(255, 0, 0, 100),
    bVis = LinearColor(0, 255, 0, 100),
    bOcc = LinearColor(255, 0, 0, 100)
}

local function SetupConsole()
    if CONSOLE_READY then return end
    pcall(function()
        local KismetSystemLibrary = import("KismetSystemLibrary")
        local world = slua.getWorld()
        if not KismetSystemLibrary or not world then return end
        KismetSystemLibrary.ExecuteConsoleCommand(world, "r.EnableDrawDyeingColor 1")
        KismetSystemLibrary.ExecuteConsoleCommand(world, "r.CustomDepth 3")
        KismetSystemLibrary.ExecuteConsoleCommand(world, "r.IdeaOutline.Enable 1")
        KismetSystemLibrary.ExecuteConsoleCommand(world, "r.Highlight.Enable 1")
        CONSOLE_READY = true
    end)
end

local function ApplyToMesh(mesh, visColor, occColor)
    if not mesh or not slua.isValid(mesh) then return end
    pcall(function()
        mesh:SetDrawDyeing(true)
        mesh:SetDrawDyeingMode(1)
        mesh:SetVisibleDyeingColor(visColor)
        mesh:SetOccludedDyeingColor(occColor)
        mesh:SetDyeingColorFadeDistance(99999.0)
        mesh:SetDyeingColorMinMaxDistance(0.0, 99999.0)
        mesh:SetDrawHighlight(true)
        mesh:OverrideHighlightColor(visColor)
        mesh:SetHighlightCanBeOccluded(false)
        mesh:SetDrawIdeaOutline(true)
        mesh:SetIdeaOutlineNew(true)
        mesh:SetIdeaOutlineOcclusionHighlight(true)
        mesh:OverrideIdeaOutlineColor(visColor)
        mesh:SetIdeaOutlineOcclusionColor(occColor)
        mesh:OverrideIdeaOutlineThickness(20.0)
        mesh:SetIdeaOverrideOutlineAndOcclusion(true)
        mesh:SetRenderCustomDepth(true)
        mesh:SetCustomDepthStencilValue(255)
    end)
end

local function IsPawnAlive(pawn)
    if not slua.isValid(pawn) then return false end
    if pawn.Health and pawn.Health > 0 then return true end
    return false
end

local function PBCtick()
    pcall(function()
        local localPawn = GameplayData.GetPlayerCharacter()
        if not slua.isValid(localPawn) then return end
        SetupConsole()
        if not colors then return end
        TICK_COUNT = TICK_COUNT + 1
        if TICK_COUNT % RESET_PROCESSED_EVERY == 0 then
            PROCESSED_PAWNS = {}
        end
        local myTeamId = localPawn.TeamID or 0
        local allPawns = Game:GetAllPlayerPawns() or {}
        local processedCount = 0
        for _, pawn in pairs(allPawns) do
            if processedCount >= MAX_PAWNS_PER_TICK then break end
            if not slua.isValid(pawn) or pawn == localPawn then goto continue end
            if pawn.PlayerKey and PROCESSED_PAWNS[pawn.PlayerKey] then goto continue end
            if IsPawnAlive(pawn) and pawn.TeamID and pawn.TeamID ~= myTeamId then
                local isAI = pcall(Game.IsAI, pawn) and true or false
                local vis = isAI and colors.bVis or colors.vis
                local occ = isAI and colors.bOcc or colors.occ
                pcall(function()
                    if slua.isValid(pawn.Mesh) then
                        ApplyToMesh(pawn.Mesh, vis, occ)
                    end
                    local avatarComp = pawn.CharacterAvatarComp2_BP or pawn:getAvatarComponent2()
                    if avatarComp and avatarComp.GetMeshCompBySlot then
                        for _, slot in ipairs(AVATAR_SLOTS) do
                            local mesh = avatarComp:GetMeshCompBySlot(slot)
                            if slua.isValid(mesh) then
                                ApplyToMesh(mesh, vis, occ)
                            end
                        end
                    end
                    pcall(function()
                        local SkeletalMeshComponent = import("SkeletalMeshComponent")
                        if SkeletalMeshComponent then
                            local skComps = pawn:GetComponentsByClass(SkeletalMeshComponent)
                            if skComps then
                                for i = 0, skComps:Num() - 1 do
                                    local comp = skComps:Get(i)
                                    if slua.isValid(comp) and comp ~= pawn.Mesh then
                                        ApplyToMesh(comp, vis, occ)
                                    end
                                end
                            end
                        end
                    end)
                    pcall(function()
                        local StaticMeshComponent = import("StaticMeshComponent")
                        if StaticMeshComponent then
                            local stComps = pawn:GetComponentsByClass(StaticMeshComponent)
                            if stComps then
                                for i = 0, stComps:Num() - 1 do
                                    local comp = stComps:Get(i)
                                    if slua.isValid(comp) then
                                        ApplyToMesh(comp, vis, occ)
                                    end
                                end
                            end
                        end
                    end)
                    local weapon = pawn:GetCurrentWeapon()
                    if slua.isValid(weapon) and slua.isValid(weapon.Mesh) then
                        ApplyToMesh(weapon.Mesh, vis, occ)
                    end
                end)
                if pawn.PlayerKey then PROCESSED_PAWNS[pawn.PlayerKey] = true end
                processedCount = processedCount + 1
            end
            ::continue::
        end
    end)
end

local function StartPBC()
    SetupConsole()
    if not colors then return false end
    if _G.WH_TIMER then
        pcall(function()
            if _G.Game then _G.Game:RemoveGameTimer(_G.WH_TIMER) end
        end)
        _G.WH_TIMER = nil
    end
    if _G.Game and _G.Game.AddGameTimer then
        _G.WH_TIMER = _G.Game:AddGameTimer(TICK_INTERVAL, true, PBCtick)
        return true
    end
    local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
    if slua.isValid(pc) and pc.AddGameTimer then
        _G.WH_TIMER = pc:AddGameTimer(TICK_INTERVAL, true, PBCtick)
        return true
    end
    return false
end

local retryCount = 0
local function RetryStart()
    if retryCount >= 30 then return end
    retryCount = retryCount + 1
    if StartPBC() then
        -- success
    else
        if _G.Game and _G.Game.AddGameTimer then
            _G.Game:AddGameTimer(1.0, false, RetryStart)
        end
    end
end

function _G.StopWallhack()
    if _G.WH_TIMER then
        pcall(function()
            if _G.Game then _G.Game:RemoveGameTimer(_G.WH_TIMER) end
        end)
        _G.WH_TIMER = nil
    end
    PROCESSED_PAWNS = {}
    CONSOLE_READY = false
end

function _pbc_Cleanup()
    _G.StopWallhack()
end

function _G.StartNewWallhack()
    if _G.AK_GetVal("WALLHACK") ~= 1 then return end
    if _G.WH_TIMER then return end
    RetryStart()
end

-- ========================== GRAPHICS BYPASS ==========================
_G.AK_GraphicsState = _G.AK_GraphicsState or {
    BlackSky = false,
    NoFog = false,
    UnlockFPS = false,
}

local function AK_InitializeGraphicsUnlock()
    if _G.AK_GraphicsState.UnlockFPS then return end
    if _G._MOD_EXPIRED then return end

    pcall(function()
        local SettingCfg = require("client.logic.setting.setting_config")
        local GraphicSettingDB = require("client.slua.umg.NewSetting.GraphicsNew.GraphicSettingDB")
        if SettingCfg then
            if SettingCfg.TpViewValue then SettingCfg.TpViewValue.max = 160 end
            if SettingCfg.FpViewValue then SettingCfg.FpViewValue.max = 160 end
        end
        if GraphicSettingDB then
            if GraphicSettingDB.TpViewValue then GraphicSettingDB.TpViewValue.max = 160 end
        end
    end)

    pcall(function()
        local logic_setting_graphics = require("client.slua.logic.setting.logic_setting_graphics")
        local GSC_FPS = require("client.slua.umg.NewSetting.GraphicsNew.Comps.GSC_FPS")
        local GSC_FPSFT = require("client.slua.umg.NewSetting.GraphicsNew.Comps.GSC_FPSFT")
        local GraphicSettingDB = require("client.slua.umg.NewSetting.GraphicsNew.GraphicSettingDB")

        local KismetMathLibrary = import("KismetMathLibrary") or _G.KismetMathLibrary
        local FLinearColor = import("LinearColor") or _G.FLinearColor

        if logic_setting_graphics then
            local old_SetFPS = logic_setting_graphics.SetFPS
            function logic_setting_graphics.SetFPS(gameInstance, FPSLevel)
                if old_SetFPS then old_SetFPS(gameInstance, FPSLevel) end
                if FPSLevel == 8 then
                    gameInstance:ExecuteCMD("t.MaxFPS", "165")
                    gameInstance:ExecuteCMD("r.FrameRateLimit", "165")
                end
            end
        end

        if GSC_FPS and GSC_FPS.__inner_impl then
            local fps_impl = GSC_FPS.__inner_impl
            function fps_impl:GetMaxFPSLevel() return 8, 8 end
            function fps_impl:InitRealSupportFPS()
                local RealSupportFPS = {}
                for i = 1, 8 do RealSupportFPS[i] = {true, true} end
                if GraphicSettingDB then GraphicSettingDB:UpdateUIData(GraphicSettingDB.RealSupportFPS, RealSupportFPS, false) end
                return RealSupportFPS
            end
            function fps_impl:UpdateSelectedFPSState(selectedLevel)
                if not slua.isValid(self.UIRoot) then return end
                for level = 2, 8 do
                    local name = "NodeFps" .. (({[2]=20,[3]=25,[4]=30,[5]=40,[6]=60,[7]=90,[8]=120})[level] or 120)
                    local widget = self.UIRoot[name]
                    if slua.isValid(widget) then
                        widget:SetIsEnabled(true)
                        pcall(function() widget:SetRenderOpacity(1.0) end)
                        local switcher = self.UIRoot["WidgetSwitcher_" .. level]
                        if slua.isValid(switcher) then
                            switcher:SetActiveWidgetIndex(level == selectedLevel and 0 or 1)
                        end
                    end
                end
            end
        end

        if GSC_FPSFT and GSC_FPSFT.__inner_impl then
            local ft_impl = GSC_FPSFT.__inner_impl
            local NMinFPS, NStep = 90, 5
            local function clamp(value, min, max)
                if value < min then return min end
                if max < value then return max end
                return value
            end
            local function lerp(a, b, t) return a + (b - a) * t end
            local function _getColorByPercent(start, finish, percent)
                if not FLinearColor then return nil end
                return FLinearColor(lerp(start.R, finish.R, percent), lerp(start.G, finish.G, percent), lerp(start.B, finish.B, percent), lerp(start.A, finish.A, percent))
            end

            ft_impl.ShowOrHide = function(self)
                self:SelfHitTestInvisible()
                if self.InitFPSFTSwitch then self:InitFPSFTSwitch() end
            end

            ft_impl.InitFPSFTSwitch = function(self)
                local FPSFineTuneSwitch = GraphicSettingDB:GetUIData(GraphicSettingDB.FPSFineTuneSwitch)
                if self.UIRoot.Setting_Switch then self.UIRoot.Setting_Switch:SetSwitcherEnable2(FPSFineTuneSwitch, true) end
                if self.UIRoot.CanvasPanel_8 then self:SetWidgetVisible(self.UIRoot.CanvasPanel_8, FPSFineTuneSwitch) end
                if self.UIRoot.WidgetSwitcher_0 then self.UIRoot.WidgetSwitcher_0:SetActiveWidgetIndex(2) end
                if self.InitFPSFTValue165 then self:InitFPSFTValue165() end
            end

            ft_impl.InitFPSFTValue165 = function(self)
                local itemRoot = self.UIRoot
                local FPSFineTuneSwitch = GraphicSettingDB:GetUIData(GraphicSettingDB.FPSFineTuneSwitch)
                local FPSFineTuneNum = 165
                if FPSFineTuneSwitch then
                    FPSFineTuneNum = GraphicSettingDB:GetUIData(GraphicSettingDB.FPSFineTuneNum) or 165
                    itemRoot.Slider_screen3:SetLocked(false)
                    if FLinearColor then
                        itemRoot.ProgressBar_screen3:SetFillColorAndOpacity(FLinearColor(1.0, 1.0, 1.0, 1.0))
                        itemRoot.Slider_screen3:SetSliderHandleColor(FLinearColor(1.0, 1.0, 1.0, 1.0))
                    end
                else
                    itemRoot.Slider_screen3:SetLocked(true)
                    if FLinearColor then
                        itemRoot.ProgressBar_screen3:SetFillColorAndOpacity(FLinearColor(1.0, 0.625, 0.6, 1))
                        itemRoot.Slider_screen3:SetSliderHandleColor(FLinearColor(1.0, 0.625, 0.6, 1.0))
                    end
                end
                local FPSFineTunePer = (FPSFineTuneNum - NMinFPS) / (165 - NMinFPS)

                itemRoot.Veihclescreen3:SetText(tostring(FPSFineTuneNum))
                itemRoot.Slider_screen3:SetValue(FPSFineTunePer)
                itemRoot.ProgressBar_screen3:SetPercent(FPSFineTunePer)

                if FLinearColor then
                    local startColor = FLinearColor(1.0, 1.0, 1.0, 1.0)
                    local midColor = FLinearColor(1.0, 0.54, 0.11, 1.0)
                    local endColor = FLinearColor(1.0, 0.23, 0.15, 1.0)
                    local sliderColor = FPSFineTunePer < 0.4 and startColor or _getColorByPercent(midColor, endColor, (FPSFineTunePer - 0.4) / 0.6)
                    itemRoot.Slider_screen3:SetSliderHandleColor(sliderColor)
                end
            end

            ft_impl.OnFPSFTValueChange3 = function(self, FPSFineTuneNum)
                GraphicSettingDB:UpdateUIData(GraphicSettingDB.FPSFineTuneNum, FPSFineTuneNum)
                if self.InitFPSFTValue165 then self:InitFPSFTValue165() end
                if self:GetParentUI() then self:GetParentUI():SetDirty(true) end
                local gameInstance = GraphicSettingDB.GetGameInstance and GraphicSettingDB.GetGameInstance()
                if gameInstance then
                    gameInstance:ExecuteCMD("t.MaxFPS", tostring(FPSFineTuneNum))
                    gameInstance:ExecuteCMD("r.FrameRateLimit", tostring(FPSFineTuneNum))
                end
            end

            ft_impl.OnFPSFTSliderValueChange3 = function(self, value)
                if GraphicSettingDB:GetUIData(GraphicSettingDB.FPSFineTuneSwitch) and KismetMathLibrary then
                    local FPSFineTuneNum = KismetMathLibrary.FCeil(value * (165 - NMinFPS) / NStep) * NStep + NMinFPS
                    self:OnFPSFTValueChange3(clamp(FPSFineTuneNum, NMinFPS, 165))
                end
            end

            ft_impl.OnFPSFTAdd = ft_impl.OnFPSFTAdd3
            ft_impl.OnFPSFTMinus = ft_impl.OnFPSFTMinus3
            ft_impl.OnFPSFTAdd2 = ft_impl.OnFPSFTAdd3
            ft_impl.OnFPSFTMinus2 = ft_impl.OnFPSFTMinus3
            ft_impl.OnFPSFTSliderValueChange = ft_impl.OnFPSFTSliderValueChange3
            ft_impl.OnFPSFTSliderValueChange2 = ft_impl.OnFPSFTSliderValueChange3
        end
    end)
    _G.AK_GraphicsState.UnlockFPS = true
    pcall(function() print("[AKMOD] Graphics & FPS 165Hz Unlocked") end)
end

_G.ApplyGraphicsBypass = function()
    if _G._MOD_EXPIRED then return end

    if _G.AK_GetVal("UNLOCK_FPS") == 1 then
        pcall(AK_InitializeGraphicsUnlock)
    end

    pcall(function()
        local lsg = require("client.slua.logic.setting.logic_setting_graphics")
        local gi = lsg.GetGameInstance()
        if not gi then return end

        if _G.AK_GetVal("BLACK_SKY") == 1 and not _G.AK_GraphicsState.BlackSky then
            gi:ExecuteCMD("r.CylinderMaxDrawHeight", "9999")
            _G.AK_GraphicsState.BlackSky = true
        elseif _G.AK_GetVal("BLACK_SKY") == 0 and _G.AK_GraphicsState.BlackSky then
            gi:ExecuteCMD("r.CylinderMaxDrawHeight", "0000")
            _G.AK_GraphicsState.BlackSky = false
        end

        if _G.AK_GetVal("NO_FOG") == 1 and not _G.AK_GraphicsState.NoFog then
            gi:ExecuteCMD("r.SkyAtmosphere", "1")
            gi:ExecuteCMD("r.Fog", "0")
            gi:ExecuteCMD("r.VolumetricFog", "0")
            _G.AK_GraphicsState.NoFog = true
        elseif _G.AK_GetVal("NO_FOG") == 0 and _G.AK_GraphicsState.NoFog then
            gi:ExecuteCMD("r.SkyAtmosphere", "1")
            gi:ExecuteCMD("r.Fog", "1")
            gi:ExecuteCMD("r.VolumetricFog", "1")
            _G.AK_GraphicsState.NoFog = false
        end
    end)
end

-- ========================== SKIN MOD SYSTEM ==========================
if not _G.FufuModConfig then _G.FufuModConfig = { ModSkin = false, EnableWeaponMod = false, WeaponMod = {} } end
if not _G.FufuModState then _G.FufuModState = { CustomTextData = {}, SkinWasApplied = false } end

_G.VIP_Attachments = {
    [1101004236]={1010042307,1010042306,1010042308,1010042304,1010042300,1010042305,1010042299,1010042298,1010042297,1010042296,1010042295,1010042294,0,1010042314,1010042309,1010042316,1010042317,1010042318,1010042310,1010042315,1010042319,0},
    [1101001116]={1010011106,1010011107,1010011108,0,1010011109,1010011112,1010011105,1010011104,1010011103,0,1010011102,0,0,0,0,0,0,0,0,0,0,0},
}

_G.BaseAttachToIndex = {
    [201010]=1, [201005]=1, [201004]=1, [201009]=2, [201003]=2, [201002]=2,
    [201011]=3, [201007]=3, [201006]=3, [204012]=4, [204005]=4, [204008]=4,
    [204011]=5, [204004]=5, [204007]=5, [204013]=6, [204006]=6, [204009]=6,
    [203001]=7, [203002]=8, [203003]=9, [203014]=10, [203004]=11, [203015]=12, [203005]=13,
    [202002]=14, [202001]=15, [202004]=16, [202005]=17, [202007]=18, [202006]=19,
    [205002]=20, [205003]=20, [205001]=20, [203018]=21, [204014]=22
}
_G.VipAttachToIndex = {}
for skinId, attachList in pairs(_G.VIP_Attachments) do
    for index, attachId in ipairs(attachList) do
        if attachId > 0 then
            _G.VipAttachToIndex[attachId] = index
        end
    end
end

_G.WeaponSkinMap = _G.WeaponSkinMap or {}
_G.VehicleSkinMap = _G.VehicleSkinMap or {}
_G.OutfitMap = _G.OutfitMap or {}
_G.skinIdCache = _G.skinIdCache or {}
_G.skinIdCache2 = _G.skinIdCache2 or {}

_G.OutfitSkins = {
    Suit = {1407994,1408021,1407906,1407453,1406388,1406387,1406386,1407142,1407550,1406638,1406872,1406971,1407103,1407512,1407391,1407285,1407330,1407329,1407286,1407285,1407277,1407276,1407275,1407225,1407224,1407259,1407161,1407160,1407107,1407106,1407079,1407048,1406977,1406976,1406898,1400569,1404000,1404049,1400119,1400117,1406060,1406891,1400687,1405160,1405145,1405436,1405435,1405434,1405064,1405207,1406398,1407812,1405132,1407856,1405121,1406889,1407278,1407279,1407381,1407380,1407916,1406469,1405870,1407140,1407141,1406385,1406140,1400782,1407392,1407318,1407317,1407404,1407402,1407401,1407387,1404434,1404437,1404440,1404448,1400324,1400708,1404043,1404048,1405953,1400101,1404153,1407440,1407441,1407522,1405069,1405355},
    Bag = {
        {501001, 501002, 501003}, {1501001174, 1501002174, 1501003174}, {1501001220, 1501002220, 1501003220},
        {1501001051, 1501002051, 1501003051}, {1501001443, 1501002443, 1501003443}, {1501001265, 1501002265, 1501003265},
        {1501001321, 1501002321, 1501003321}, {1501001277, 1501002277, 1501003277}, {1501001550, 1501002550, 1501003550},
        {1501001592, 1501002592, 1501003592}, {1501001608, 1501002608, 1501003608}, {1501001024, 1501002024, 1501003024},
        {1501001019, 1501002019, 1501003019}, {1501001179, 1501002179, 1501003179}, {1501001194, 1501002194, 1501003194},
        {1501001346, 1501002346, 1501003346}, {1501001057, 1501002057, 1501003057}, {1501001229, 1501002229, 1501003229},
        {1501001022, 1501002022, 1501003022}, {1501001022, 1501002022, 1501003022}
    },
    Helmet = {
        {502001, 502002, 502003}, {1502001014, 1502002014, 1502003014}, {1502001349, 1502002349, 1502003349},
        {1502001012, 1502002012, 1502003012}, {1502001009, 1502002009, 1502003009}, {1502001397, 1502002397, 1502003397},
        {1502001390, 1502002390, 1502003390}, {1502001381, 1502002381, 1502003381}, {1502001358, 1502002358, 1502003358},
        {1502001350, 1502002350, 1502003350}, {1502001342, 1502002342, 1502003342}, {1502001058, 1502002058, 1502003058},
        {1502001031, 1502002031, 1502003031}, {1502001054, 1502002054, 1502003054}
    },
    Pet = {50000,50001,50002,50003,50004,50005,50006,50021,50022,50038,50039,50040},
    Glider = {41511, 4151145},
    Parachute = {14011, 1401107},
    Gloves = {4520, 452001, 452002, 452003},
}

_G.skinIdMappings = {
    [101004] = {101004, 1101004246,1101004209,1101004226,1101004236,1101004062,1101004078,1101004086,1101004201,1101004218,1101004046},
    [101001] = {101001,1101001276,1101001265,1101001213,1101001172,1101001127,1101001230,1101001241},
    [101003] = {101003,1101003227,1103003208,1101003195,1101003187,1101003098,1101003166,1101003218},
    [101008] = {101008,1101008146,1101008154,1101008079,1101008126,1101008104,1101008146,1101008061,1101008116},
    [101006] = {101006,1101006106,1101006098,1101006085,1101006061,1101006074,1101006043,1101006032,1101006084},
    [101012] = {101012,1101012033},
    [101007] = {101007,1101007062,1101007071},
    [102002] = {102002,1102002136,1102002043,1102002061,1102002424,1102002438},
    [101101] = {101101, 1101101007},
    [101102] = {101102, 1101102041},
    [102001] = {102001, 1102001120},
    [102003] = {102003, 1102003100},
    [101005] = {101005, 1101005098},
    [103001] = {103001, 1103001202,1103001191},
    [103002] = {103002, 1103002106},
    [103003] = {103003, 1103003042,1103003062,1103003099},
    [103012] = {103012, 1103012039,1103012010},
    [104003] = {104003, 1104003037},
    [102005] = {102005, 1102005064},
    [104004] = {104004, 1104004035, 1104004041}
}

_G.VehicleSkins = {
    [1961001] = { 1961007, 1961149, 1961069, 1961013, 1961014, 1961015, 1961016, 1961017, 1961018, 1961020, 1961021, 1961024, 1961025, 1961029, 1961030, 1961031, 1961032, 1961033, 1961034, 1961035, 1961036, 1961037, 1961038, 1961039, 1961040, 1961041, 1961042, 1961043, 1961044, 1961045, 1961046, 1961047, 1961048, 1961049, 1961050, 1961051, 1961052, 1961053, 1961054, 1961055, 1961056, 1961057, 1961058, 1961059, 1961060, 1961061, 1961062, 1961063, 1961064, 1961065, 1961066, 1961067, 1961068,1961136, 1961137, 1961138, 1961139, 1961140, 1961141, 1961142, 1961143, 1961144, 1961145, 1961147, 1961148, 1961010, 1961150, 1961151, 1961152, 1961153 },
    [1903001] = { 1903005, 1903006, 1903007, 1903008, 1903011, 1903012, 1903013, 1903014, 1903015, 1903016, 1903017, 1903018, 1903019, 1903020, 1903021, 1903022, 1903023, 1903024, 1903029, 1903030, 1903031, 1903032, 1903033, 1903034, 1903035, 1903036, 1903037, 1903039, 1903040, 1903041, 1903042, 1903043, 1903044, 1903045, 1903046, 1903051, 1903052, 1903053, 1903054, 1903055, 1903056, 1903057, 1903058, 1903059, 1903060, 1903061, 1903062, 1903063, 1903066, 1903067, 1903068, 1903069, 1903070, 1903071, 1903072, 1903073, 1903074, 1903075, 1903076, 1903079, 1903080, 1903081, 1903082, 1903084, 1903085, 1903086, 1903087, 1903088, 1903089, 1903090, 1903189, 1903190, 1903191, 1903192, 1903193, 1903194, 1903195, 1903196, 1903197, 1903198, 1903199, 1903200, 1903201, 1903202, 1903203, 1903204, 1903205, 1903206, 1903207, 1903208, 1903209, 1903210, 1903211, 1903212, 1903213, 1903214, 1903215, 1903216, 1903217, 1903218, 1903219, 1903220, 1903221, 1903222, 1903223, 1903225, 1903226, 1903227, 1903228 },
    [1915001] = { 1915002, 1915003, 1915007, 1915005, 1915006, 1915008, 1915009, 1915010, 1915011, 1915012, 1915013, 1915014, 1915015, 1915016, 1915017, 1915018, 1915019, 1915020, 1915021, 1915022, 1915023, 1915024, 1915025, 1915026, 1915027, 1915099 },
    [1908001] = { 1908002, 1908003, 1908094, 1908006, 1908007, 1908008, 1908009, 1908010, 1908011, 1908012, 1908013, 1908015, 1908016, 1908017, 1908018, 1908019, 1908021, 1908023, 1908030, 1908031, 1908032, 1908033, 1908034, 1908035, 1908036, 1908037, 1908039, 1908040, 1908041, 1908043, 1908047, 1908049, 1908050, 1908051, 1908052, 1908053, 1908054, 1908055, 1908056, 1908057, 1908059, 1908060, 1908061, 1908062, 1908063, 1908064, 1908066, 1908067, 1908068, 1908069, 1908070, 1908075, 1908076, 1908077, 1908078, 1908080, 1908081, 1908082, 1908083, 1908084, 1908085, 1908086, 1908087, 1908088, 1908089, 1908091, 1908095, 1908096, 1908097, 1908098, 1908099, 1908100, 1908101, 1908102, 1908104, 1908105, 1908106, 1908107, 1908108, 1908109, 1908110, 1908111, 1908112, 1908188, 1908189 },
    [1907001] = { 1907007, 1907008, 1907010, 1907011, 1907012, 1907013, 1907014, 1907016, 1907018, 1907019, 1907021, 1907022, 1907023, 1907025, 1907026, 1907027, 1907028, 1907029, 1907030, 1907032, 1907033, 1907034, 1907035, 1907036, 1907037, 1907038, 1907040, 1907041, 1907043, 1907044, 1907045, 1907046, 1907047, 1907048, 1907049, 1907050, 1907051, 1907052, 1907053, 1907054, 1907055, 1907056, 1907058, 1907059, 1907060, 1907061, 1907062, 1907063, 1907064, 1907065, 1907066, 1907067, 1907068, 1907069, 1907070, 1907071, 1907072, 1907073, 1907074 }
}

_G.CustSlotType = { ClothesEquipemtSlot=5, BackpackEquipemtSlot=8, HelmetEquipemtSlot=9, ParachuteEquipemtSlot=11, GlideEquipemtSlot=15 }

local function DownloadGameItem(id)
    local puffer_manager = require('client.slua.logic.download.puffer.puffer_manager')
    local puffer_const = require('client.slua.logic.download.puffer_const')
    if puffer_manager and puffer_const and puffer_manager.GetState(puffer_const.ENUM_DownloadType.ODPTD, {id}) ~= puffer_const.ENUM_DownloadState.Done then
        puffer_manager.Download(puffer_const.ENUM_DownloadType.ODPTD, {id})
    end
end
_G.download_item = DownloadGameItem

_G.get_skin_id = function(weaponID)
    if not weaponID then return nil end
    local targetSkinId = _G.WeaponSkinMap and _G.WeaponSkinMap[weaponID]
    if targetSkinId and targetSkinId > 0 then
        if not _G.skinIdCache2[targetSkinId] then
            if _G.download_item then pcall(_G.download_item, targetSkinId) end
            _G.skinIdCache2[targetSkinId] = true
        end
        return targetSkinId
    end
    return weaponID
end

_G.equip_character_avatar = function(Character)
    if not Character or not slua.isValid(Character) or not Character.AvatarComponent2 then return end
    local BackpackUtils = import("BackpackUtils")
    local SlotSyncData = Character.AvatarComponent2.NetAvatarData and Character.AvatarComponent2.NetAvatarData.SlotSyncData
    if not SlotSyncData or not slua.isValid(SlotSyncData) or not BackpackUtils then return end

    local function EquipAvatar(ApplyDataIdx, mappedSkin, ApplyEquipSlot, isLevelDependent, levelFunc)
        if not mappedSkin or mappedSkin == 0 then return end
        local slotData = SlotSyncData:Get(ApplyDataIdx)
        if slotData and slotData.SlotID == ApplyEquipSlot then
            local applyItemId = mappedSkin
            if isLevelDependent and type(mappedSkin) == "table" then
                local level = levelFunc(slotData.AdditionalItemID) or 1
                if level < 1 then level = 1 end
                if level > 3 then level = 3 end
                applyItemId = mappedSkin[level] or mappedSkin[1]
            end
            if not applyItemId or applyItemId == 0 or slotData.ItemId == applyItemId then return end
            if not _G.skinIdCache[applyItemId] then
                if _G.download_item then pcall(_G.download_item, applyItemId) end
                _G.skinIdCache[applyItemId] = true
            end
            slotData.ItemId = applyItemId
            SlotSyncData:Set(ApplyDataIdx, slotData)
            Character.AvatarComponent2:OnRep_BodySlotStateChanged()
        end
    end

    local hasGliderSlot = false
    local hasParachuteSlot = false
    for i = 0, SlotSyncData:Num() - 1 do
        local slotData = SlotSyncData:Get(i)
        if slotData then
            if slotData.SlotID == _G.CustSlotType.GlideEquipemtSlot then hasGliderSlot = true end
            if slotData.SlotID == _G.CustSlotType.ParachuteEquipemtSlot then hasParachuteSlot = true end
        end
    end
    if not hasGliderSlot then
        SlotSyncData:Add({ SlotID = _G.CustSlotType.GlideEquipemtSlot, ItemId = 0 })
    end
    if not hasParachuteSlot then
        SlotSyncData:Add({ SlotID = _G.CustSlotType.ParachuteEquipemtSlot, ItemId = 0 })
    end

    for i = 0, SlotSyncData:Num() - 1 do
        EquipAvatar(i, _G.OutfitMap.Suit or 0, _G.CustSlotType.ClothesEquipemtSlot, false)
        EquipAvatar(i, _G.OutfitMap.Bag, _G.CustSlotType.BackpackEquipemtSlot, true, BackpackUtils.GetEquipmentBagLevel)
        EquipAvatar(i, _G.OutfitMap.Helmet, _G.CustSlotType.HelmetEquipemtSlot, true, BackpackUtils.GetEquipmentHelmetLevel)
        EquipAvatar(i, _G.OutfitMap.Parachute or 0, _G.CustSlotType.ParachuteEquipemtSlot, false)
        EquipAvatar(i, _G.OutfitMap.Glider or 0, _G.CustSlotType.GlideEquipemtSlot, false)
        EquipAvatar(i, _G.OutfitMap.Gloves or 0, 6, false)
    end
end

_G.ApplyWeaponSkins = function(PlayerCharacter)
    pcall(function()
        local WeaponManager = PlayerCharacter:GetWeaponManager()
        if not slua.isValid(WeaponManager) then return end

        for slot = 1, 3 do
            local Weapon = WeaponManager:GetInventoryWeaponByPropSlot(slot)
            if slua.isValid(Weapon) and slua.isValid(Weapon.synData) then
                local WeaponID = Weapon:GetWeaponID()
                local SkinID = _G.get_skin_id(WeaponID) or WeaponID
                local isModified = false

                local SkinData = Weapon.synData:Get(7)
                if SkinData and SkinData.defineID and SkinData.defineID.TypeSpecificID ~= SkinID then
                    SkinData.defineID.TypeSpecificID = SkinID
                    Weapon.synData:Set(7, SkinData)
                    if Weapon.SetWeaponAvatarID then pcall(function() Weapon:SetWeaponAvatarID(SkinID) end) end
                    if not _G.skinIdCache[SkinID] then
                        _G.download_item(SkinID)
                        _G.skinIdCache[SkinID] = true
                    end
                    isModified = true
                end

                if SkinID >= 10000000 and _G.VIP_Attachments and _G.VIP_Attachments[SkinID] then
                    for AttachIdx = 0, 5 do
                        local attachData = Weapon.synData:Get(AttachIdx)
                        if attachData then
                            local defineIDRef = slua.IndexReference(attachData, "defineID")
                            if defineIDRef then
                                local attachmentId = defineIDRef.TypeSpecificID
                                if attachmentId and attachmentId > 0 then
                                    local mapIndex = _G.BaseAttachToIndex[attachmentId] or _G.VipAttachToIndex[attachmentId]
                                    if mapIndex and _G.VIP_Attachments[SkinID][mapIndex] and _G.VIP_Attachments[SkinID][mapIndex] > 0 then
                                        local targetAttachId = _G.VIP_Attachments[SkinID][mapIndex]
                                        if targetAttachId ~= attachmentId then
                                            attachData.defineID.TypeSpecificID = targetAttachId
                                            Weapon.synData:Set(AttachIdx, attachData)
                                            if not _G.skinIdCache2[targetAttachId] then
                                                if _G.download_item then pcall(_G.download_item, targetAttachId) end
                                                _G.skinIdCache2[targetAttachId] = true
                                            end
                                            isModified = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                if isModified then
                    if Weapon.DelayHandleAvatarMeshChanged then pcall(function() Weapon:DelayHandleAvatarMeshChanged() end) end
                    if Weapon.OnRep_synData then pcall(function() Weapon:OnRep_synData() end) end
                end
            end
        end
    end)
end

_G.ApplyVehicleSkins = function(PlayerCharacter)
    pcall(function()
        local Vehicle = PlayerCharacter:GetCurrentVehicle()
        if not slua.isValid(Vehicle) then
            _G.LastVehicleEntity = nil
            return
        end

        if _G.LastVehicleEntity == Vehicle and _G.CurrentEquipVehicleID ~= nil then
            return
        end

        local VehicleAvatar = Vehicle.VehicleAvatar or Vehicle.VehicleAvatarComponent_BP or Vehicle:GetAvatarComponent()
        if not slua.isValid(VehicleAvatar) then return end

        local defId = tostring(VehicleAvatar:GetDefaultAvatarID() or Vehicle.VehicleID or "")
        local currentId = tostring(Vehicle:GetAvatarId() or "")
        local applySkinId = 0

        for baseMapId, targetSkin in pairs(_G.VehicleSkinMap) do
            if defId:find(tostring(baseMapId)) or currentId:find(tostring(baseMapId)) then
                applySkinId = targetSkin
                break
            end
        end

        if applySkinId and applySkinId > 0 then
            _G.skinIdCache = _G.skinIdCache or {}
            if not _G.skinIdCache[applySkinId] then
                if _G.download_item then pcall(_G.download_item, applySkinId) end
                _G.skinIdCache[applySkinId] = true
            end

            VehicleAvatar.curSwitchEffectId = 7303001
            if VehicleAvatar.ChangeItemAvatar then VehicleAvatar:ChangeItemAvatar(applySkinId, true) end

            _G.CurrentEquipVehicleID = applySkinId
            _G.LastVehicleEntity = Vehicle
        end
    end)
end

_G.ApplyWeaponMod = function(weapon)
    if not _G.FufuModConfig.EnableWeaponMod then return end
    if not slua.isValid(weapon) then return end
    pcall(function()
        local wid = type(weapon.GetWeaponID) == "function" and weapon:GetWeaponID() or 0
        local cfg = _G.FufuModConfig.WeaponMod[wid]
        if not cfg then return end
        local shootComp = weapon.ShootWeaponEntityComp or weapon.ShootWeaponEntity or weapon
        if not slua.isValid(shootComp) then return end
        if cfg.FireSpeed then
            if shootComp.ShootInterval then shootComp.ShootInterval = 0.07 end
            if shootComp.FireRate then shootComp.FireRate = 0.07 end
        end
        if cfg.InstanHit then
            if shootComp.BulletFireSpeed then shootComp.BulletFireSpeed = 150000 end
        end
        if cfg.FastSwitch then
            if shootComp.SwitchFromIdleToBackpackTime then shootComp.SwitchFromIdleToBackpackTime = 0 end
            if shootComp.SwitchFromBackpackToIdleTime then shootComp.SwitchFromBackpackToIdleTime = 0 end
        end
        if cfg.FastScope then
            if shootComp.WeaponAimInTime then shootComp.WeaponAimInTime = 7 end
        end
    end)
end

_G.HandlePetLogic = function()
    pcall(function()
        local petSkin = _G.OutfitMap.Pet
        if not petSkin or petSkin == 0 or petSkin == 50000 or petSkin == _G.LastAppliedPet then return end
        _G.skinIdCache = _G.skinIdCache or {}
        if not _G.skinIdCache[petSkin] then
            if _G.download_item then pcall(_G.download_item, petSkin) end
            _G.skinIdCache[petSkin] = true
        end
        local ModuleManager = require("client.module_framework.ModuleManager")
        if ModuleManager then
            local logic_pet = ModuleManager.GetModule(ModuleManager.CommonModuleConfig.logic_pet)
            if logic_pet then
                if logic_pet.SetCurPetID then logic_pet:SetCurPetID(petSkin) end
                if logic_pet.EquipPet then logic_pet:EquipPet(petSkin) end
            end
        end
        _G.LastAppliedPet = petSkin
    end)
end

_G.ForceRefreshSkinMaps = function()
    pcall(function()
        if not _G.FufuModState or not _G.FufuModState.CustomTextData then return end
        local cData = _G.FufuModState.CustomTextData
        if _G.OutfitSkins then
            if cData.SkinSuit and _G.OutfitSkins.Suit[cData.SkinSuit] then _G.OutfitMap.Suit = _G.OutfitSkins.Suit[cData.SkinSuit] end
            if cData.SkinBag and _G.OutfitSkins.Bag[cData.SkinBag] then _G.OutfitMap.Bag = _G.OutfitSkins.Bag[cData.SkinBag] end
            if cData.SkinHelmet and _G.OutfitSkins.Helmet[cData.SkinHelmet] then _G.OutfitMap.Helmet = _G.OutfitSkins.Helmet[cData.SkinHelmet] end
            if cData.SkinGloves and _G.OutfitSkins.Gloves and _G.OutfitSkins.Gloves[cData.SkinGloves] then
                _G.OutfitMap.Gloves = _G.OutfitSkins.Gloves[cData.SkinGloves]
            end
        end
        if _G.skinIdMappings then
            if cData.SkinM416 and _G.skinIdMappings[101004] and _G.skinIdMappings[101004][cData.SkinM416] then _G.WeaponSkinMap[101004] = _G.skinIdMappings[101004][cData.SkinM416] end
            if cData.SkinAKM and _G.skinIdMappings[101001] and _G.skinIdMappings[101001][cData.SkinAKM] then _G.WeaponSkinMap[101001] = _G.skinIdMappings[101001][cData.SkinAKM] end
            if cData.SkinSCAR and _G.skinIdMappings[101003] and _G.skinIdMappings[101003][cData.SkinSCAR] then _G.WeaponSkinMap[101003] = _G.skinIdMappings[101003][cData.SkinSCAR] end
            if cData.SkinM762 and _G.skinIdMappings[101008] and _G.skinIdMappings[101008][cData.SkinM762] then _G.WeaponSkinMap[101008] = _G.skinIdMappings[101008][cData.SkinM762] end
            if cData.SkinAUG and _G.skinIdMappings[101006] and _G.skinIdMappings[101006][cData.SkinAUG] then _G.WeaponSkinMap[101006] = _G.skinIdMappings[101006][cData.SkinAUG] end
            if cData.SkinHoney and _G.skinIdMappings[101012] and _G.skinIdMappings[101012][cData.SkinHoney] then _G.WeaponSkinMap[101012] = _G.skinIdMappings[101012][cData.SkinHoney] end
            if cData.SkinQBZ and _G.skinIdMappings[101007] and _G.skinIdMappings[101007][cData.SkinQBZ] then _G.WeaponSkinMap[101007] = _G.skinIdMappings[101007][cData.SkinQBZ] end
            if cData.SkinASM and _G.skinIdMappings[101101] and _G.skinIdMappings[101101][cData.SkinASM] then _G.WeaponSkinMap[101101] = _G.skinIdMappings[101101][cData.SkinASM] end
            if cData.SkinACE32 and _G.skinIdMappings[101102] and _G.skinIdMappings[101102][cData.SkinACE32] then _G.WeaponSkinMap[101102] = _G.skinIdMappings[101102][cData.SkinACE32] end
            if cData.SkinUMP and _G.skinIdMappings[102002] and _G.skinIdMappings[102002][cData.SkinUMP] then _G.WeaponSkinMap[102002] = _G.skinIdMappings[102002][cData.SkinUMP] end
            if cData.SkinUZI and _G.skinIdMappings[102001] and _G.skinIdMappings[102001][cData.SkinUZI] then _G.WeaponSkinMap[102001] = _G.skinIdMappings[102001][cData.SkinUZI] end
            if cData.SkinVector and _G.skinIdMappings[102003] and _G.skinIdMappings[102003][cData.SkinVector] then _G.WeaponSkinMap[102003] = _G.skinIdMappings[102003][cData.SkinVector] end
            if cData.SkinBIZON and _G.skinIdMappings[102005] and _G.skinIdMappings[102005][cData.SkinBIZON] then
                _G.WeaponSkinMap[102005] = _G.skinIdMappings[102005][cData.SkinBIZON]
            end
            if cData.SkinGroza and _G.skinIdMappings[101005] and _G.skinIdMappings[101005][cData.SkinGroza] then _G.WeaponSkinMap[101005] = _G.skinIdMappings[101005][cData.SkinGroza] end
            if cData.SkinKar98K and _G.skinIdMappings[103001] and _G.skinIdMappings[103001][cData.SkinKar98K] then _G.WeaponSkinMap[103001] = _G.skinIdMappings[103001][cData.SkinKar98K] end
            if cData.SkinM24 and _G.skinIdMappings[103002] and _G.skinIdMappings[103002][cData.SkinM24] then _G.WeaponSkinMap[103002] = _G.skinIdMappings[103002][cData.SkinM24] end
            if cData.SkinAWM and _G.skinIdMappings[103003] and _G.skinIdMappings[103003][cData.SkinAWM] then _G.WeaponSkinMap[103003] = _G.skinIdMappings[103003][cData.SkinAWM] end
            if cData.SkinAMR and _G.skinIdMappings[103012] and _G.skinIdMappings[103012][cData.SkinAMR] then _G.WeaponSkinMap[103012] = _G.skinIdMappings[103012][cData.SkinAMR] end
            if cData.SkinS12K and _G.skinIdMappings[104003] and _G.skinIdMappings[104003][cData.SkinS12K] then _G.WeaponSkinMap[104003] = _G.skinIdMappings[104003][cData.SkinS12K] end
            if cData.SkinDBS and _G.skinIdMappings[104004] and _G.skinIdMappings[104004][cData.SkinDBS] then _G.WeaponSkinMap[104004] = _G.skinIdMappings[104004][cData.SkinDBS] end
        end
        if _G.VehicleSkins then
            if cData.SkinDacia and _G.VehicleSkins[1903001] and _G.VehicleSkins[1903001][cData.SkinDacia] then _G.VehicleSkinMap[1903001] = _G.VehicleSkins[1903001][cData.SkinDacia] end
            if cData.SkinUAZ and _G.VehicleSkins[1908001] and _G.VehicleSkins[1908001][cData.SkinUAZ] then _G.VehicleSkinMap[1908001] = _G.VehicleSkins[1908001][cData.SkinUAZ] end
            if cData.SkinCoupe and _G.VehicleSkins[1961001] and _G.VehicleSkins[1961001][cData.SkinCoupe] then _G.VehicleSkinMap[1961001] = _G.VehicleSkins[1961001][cData.SkinCoupe] end
            if cData.SkinBuggy and _G.VehicleSkins[1907001] and _G.VehicleSkins[1907001][cData.SkinBuggy] then _G.VehicleSkinMap[1907001] = _G.VehicleSkins[1907001][cData.SkinBuggy] end
            if cData.SkinMirado and _G.VehicleSkins[1915001] and _G.VehicleSkins[1915001][cData.SkinMirado] then _G.VehicleSkinMap[1915001] = _G.VehicleSkins[1915001][cData.SkinMirado] end
            if cData.SkinParachute and _G.OutfitSkins.Parachute[cData.SkinParachute] then _G.OutfitMap.Parachute = _G.OutfitSkins.Parachute[cData.SkinParachute] end
            if cData.SkinGlider and _G.OutfitSkins.Glider[cData.SkinGlider] then _G.OutfitMap.Glider = _G.OutfitSkins.Glider[cData.SkinGlider] end
        end
    end)
end

_G.InitializeSkinModSystem = function()
    pcall(function()
        local LobbyAvatar = package.loaded["client.logic.avatar.LobbyAvatar"] or require("client.logic.avatar.LobbyAvatar")
        if LobbyAvatar and not _G.LobbyBypassHacked then
            local originalPutonEquipment = LobbyAvatar.PutonEquipment
            LobbyAvatar.PutonEquipment = function(self, itemID, tAvatarCustom, tExtraData)
                local attachIndex = _G.BaseAttachToIndex and _G.BaseAttachToIndex[itemID]
                if attachIndex then
                    local holdingWeaponSkinID = self.GetCurHoldingWeaponSkinID and self:GetCurHoldingWeaponSkinID()
                    if holdingWeaponSkinID and holdingWeaponSkinID >= 10000000 and _G.VIP_Attachments and _G.VIP_Attachments[holdingWeaponSkinID] then
                        local vipAttachID = _G.VIP_Attachments[holdingWeaponSkinID][attachIndex]
                        if vipAttachID and vipAttachID > 0 then
                            if self.HandleDownload then self:HandleDownload(vipAttachID, nil, nil, false) end
                            itemID = vipAttachID
                        end
                    end
                end
                if originalPutonEquipment then return originalPutonEquipment(self, itemID, tAvatarCustom, tExtraData) end
            end

            local originalCharEquipWeaponByResId = LobbyAvatar.CharEquipWeaponByResId
            LobbyAvatar.CharEquipWeaponByResId = function(self, resID, isUse, isAsync, SocketName)
                local retValue = originalCharEquipWeaponByResId and originalCharEquipWeaponByResId(self, resID, isUse, isAsync, SocketName) or nil
                if isUse and self.GetEquipments then
                    local equipments = self:GetEquipments()
                    for _, equip in ipairs(equipments) do
                        if _G.BaseAttachToIndex and _G.BaseAttachToIndex[equip.itemID] then
                            self:PutonEquipment(equip.itemID, equip.CustomInfo, {bIsUse = false})
                        end
                    end
                end
                return retValue
            end
            _G.LobbyBypassHacked = true
        end
    end)

    pcall(function()
        local Common_Items_UIBP = package.loaded["client.slua.component.item.ItemChildren.Common_Items_UIBP"] or require("client.slua.component.item.ItemChildren.Common_Items_UIBP")
        if Common_Items_UIBP and not _G.IconBaloHacked then
            local originalInitView = Common_Items_UIBP.InitView
            Common_Items_UIBP.InitView = function(self, nItemId, nCount, nValidTime, tExtraData)
                tExtraData = tExtraData or {}
                local displayResId = nil

                if _G.get_skin_id then
                    local skinID = _G.get_skin_id(nItemId)
                    if skinID and skinID ~= nItemId then displayResId = skinID end
                end

                local attachIndex = _G.BaseAttachToIndex and _G.BaseAttachToIndex[nItemId]
                if not displayResId and attachIndex then
                    local GameplayData = require("GameLua.GameCore.Data.GameplayData")
                    local LocalPlayer = GameplayData and GameplayData.GetPlayerCharacter()
                    if slua.isValid(LocalPlayer) then
                        local currentWeapon = LocalPlayer:GetCurrentWeapon()
                        if slua.isValid(currentWeapon) then
                            local weaponID = currentWeapon:GetWeaponID()
                            local finalSkinID = _G.get_skin_id(weaponID) or weaponID
                            if finalSkinID >= 10000000 and _G.VIP_Attachments and _G.VIP_Attachments[finalSkinID] then
                                local vipAttachID = _G.VIP_Attachments[finalSkinID][attachIndex]
                                if vipAttachID and vipAttachID > 0 then displayResId = vipAttachID end
                            end
                        end
                    end
                end

                if displayResId then
                    tExtraData.displayResId = displayResId
                    if not _G.skinIdCache2[displayResId] then
                        if _G.download_item then pcall(_G.download_item, displayResId) end
                        _G.skinIdCache2[displayResId] = true
                    end
                end
                if originalInitView then return originalInitView(self, nItemId, nCount, nValidTime, tExtraData) end
            end
            _G.IconBaloHacked = true
        end
    end)
end

-- ========================== KILL COUNTER & DEADBOX ==========================
_G.TDFTDeKillCounts = _G.TDFTDeKillCounts or {}
local CACHED_LinearColor = import("LinearColor")
local CACHED_GoldColor = CACHED_LinearColor and CACHED_LinearColor(1.0, 0.8, 0.0, 1.0) or nil
local CACHED_UI_Manager = nil
_G.NeedCheckDeadBoxTimer = 0
_G.LastCheckDeadBoxTime = 0

_G.ForceEnableKillCounterUI = function()
    pcall(function()
        local KillCounterUISubsystem = package.loaded["GameLua.Mod.BaseMod.Client.KillCounter.KillCounterUISubsystem"] or require("GameLua.Mod.BaseMod.Client.KillCounter.KillCounterUISubsystem")
        if KillCounterUISubsystem and KillCounterUISubsystem.__inner_impl and not _G.KCUISystemHacked2 then
            local kcImpl = KillCounterUISubsystem.__inner_impl
            kcImpl.CheckSupportKCUI = function() return true end
            kcImpl.CheckNeedMainKillCounterUI = function(self, PlayerWeapon, PlayerID)
                if slua.isValid(PlayerWeapon) then
                    local WeaponID = PlayerWeapon:GetWeaponID()
                    self:UpdateMainKillCounterUI(true, WeaponID, _G.get_skin_id(WeaponID) or WeaponID)
                else self:UpdateMainKillCounterUI(false) end
            end
            local originalUpdateMainKillCounterUI = kcImpl.UpdateMainKillCounterUI
            kcImpl.UpdateMainKillCounterUI = function(self, bShow, WeaponID, AvatarID)
                if bShow then AvatarID = _G.get_skin_id(WeaponID) or AvatarID end
                if originalUpdateMainKillCounterUI then originalUpdateMainKillCounterUI(self, bShow, WeaponID, AvatarID) end
            end
            _G.KCUISystemHacked2 = true
        end

        local ModuleManager = require("client.module_framework.ModuleManager")
        if ModuleManager and not _G.KCLogicHacked2 then
            local LogicKillCounter = ModuleManager.GetModule(ModuleManager.CommonModuleConfig.LogicKillCounter)
            if LogicKillCounter then
                LogicKillCounter.CheckSupportKC = function() return true end
                LogicKillCounter.CheckSupportKillCounterAvatar = function() return true end
                LogicKillCounter.CheckHasWeaponKillCounter = function() return true end
                LogicKillCounter.GetBaseKillCounterIdByWeaponId = function() return 2100004 end
                LogicKillCounter.GetEquipedKillCounterId = function() return 2100004 end
                LogicKillCounter.GetMyEquipedKillCounterId = function() return 2100004 end
                LogicKillCounter.GetOneWeaponKillCountInBattle = function(self, uid, weaponId) return _G.TDFTDeKillCounts[weaponId] or 0 end
                LogicKillCounter.GetWeaponKillCountByUid = function(self, uid, weaponId) return _G.TDFTDeKillCounts[weaponId] or 0 end
                _G.KCLogicHacked2 = true
            end
        end

        local killInfoPath = "GameLua.Mod.BaseMod.Client.KillInfoTips.KillInfo"
        local KillInfo = package.loaded[killInfoPath] or require(killInfoPath)

        if KillInfo and KillInfo.__inner_impl and not _G.KillInfoCounterHacked then
            local originalFileItem = KillInfo.__inner_impl.FileItem
            KillInfo.__inner_impl.FileItem = function(self, DamageRecordData)
                pcall(function()
                    local LocalPlayer = require("GameLua.GameCore.Data.GameplayData").GetPlayerCharacter()
                    if slua.isValid(LocalPlayer) and DamageRecordData.Causer == LocalPlayer:GetPlayerNameSafety() then
                        local currentWeapon = LocalPlayer:GetCurrentWeapon()
                        if slua.isValid(currentWeapon) then
                            local weaponID = currentWeapon:GetWeaponID()
                            local skinID = _G.get_skin_id(weaponID)
                            if skinID then DamageRecordData.CauserWeaponAvatarID = skinID end
                            if _G.OutfitMap.Suit and _G.OutfitMap.Suit ~= 0 then DamageRecordData.CauserClothAvatarID = _G.OutfitMap.Suit end

                            if CACHED_GoldColor then
                                DamageRecordData.IsUseColor, DamageRecordData.UseColor = true, CACHED_GoldColor
                            end

                            if DamageRecordData.ResultHealthStatus == 2 then
                                _G.TDFTDeKillCounts[weaponID] = (_G.TDFTDeKillCounts[weaponID] or 0) + 1
                                _G.NeedCheckDeadBoxTimer = 50

                                if not CACHED_UI_Manager then CACHED_UI_Manager = require("client.slua_ui_framework.manager") end
                                local uiMainKillCounter = CACHED_UI_Manager.GetUI(CACHED_UI_Manager.UI_Config_InGame.MainKillCounter)

                                if uiMainKillCounter and uiMainKillCounter.UpdateWeaponID then
                                    local mainAvatarID = skinID or currentWeapon:GetWeaponMainAvatarID()
                                    uiMainKillCounter:UpdateWeaponID(weaponID, mainAvatarID)
                                    local kcModule = ModuleManager.GetModule(ModuleManager.CommonModuleConfig.LogicKillCounter)
                                    local kcItemID = kcModule:GetEquipedKillCounterId(0, mainAvatarID)
                                    uiMainKillCounter:SetKillCounterItemShowWithNum(kcItemID, _G.TDFTDeKillCounts[weaponID], mainAvatarID)
                                end
                            end
                        end
                    end
                end)
                if originalFileItem then return originalFileItem(self, DamageRecordData) end
            end
            _G.KillInfoCounterHacked = true
        end

        local SwitchWeaponSlotMode2 = package.loaded["GameLua.Mod.BaseMod.Client.MainControlUI.SwitchWeaponSlotMode2"] or require("GameLua.Mod.BaseMod.Client.MainControlUI.SwitchWeaponSlotMode2")
        if SwitchWeaponSlotMode2 and SwitchWeaponSlotMode2.__inner_impl and not _G.SlotBaseHacked then
            SwitchWeaponSlotMode2.__inner_impl.CheckShowKCIcon = function(self)
                if slua.isValid(self.KillCounterImg) then
                    self.KillCounterImg:SetVisibility(import("ESlateVisibility").SelfHitTestInvisible)
                end
            end
            _G.SlotBaseHacked = true
        end
    end)
end

local cached_GameplayStatics = nil
local cached_PlayerTombBox = nil
local cached_ActorClass = nil
_G.DeadBox_TemperRequest = function(PlayerController)
    if _G.NeedCheckDeadBoxTimer <= 0 then return end
    local curTime = os.clock()
    if _G.LastCheckDeadBoxTime and (curTime - _G.LastCheckDeadBoxTime) < 2.0 then return end
    _G.LastCheckDeadBoxTime = curTime
    _G.NeedCheckDeadBoxTimer = _G.NeedCheckDeadBoxTimer - 1

    local PlayerCharacter = PlayerController:GetPlayerCharacterSafety()
    if not slua.isValid(PlayerCharacter) then return end

    if not cached_GameplayStatics then
        cached_GameplayStatics = import("GameplayStatics")
        cached_ActorClass = import("Actor")
        cached_PlayerTombBox = import("PlayerTombBox")
    end

    if not _G.CachedActorArray then
        _G.CachedActorArray = slua.Array(UEnums.EPropertyClass.Object, cached_ActorClass)
    end

    local UI_Util = require("client.common.ui_util")
    local GameInstance = UI_Util and UI_Util.GetGameInstance()
    if not GameInstance or not cached_GameplayStatics then return end

    local deadBoxes = cached_GameplayStatics.GetAllActorsOfClass(GameInstance, cached_PlayerTombBox, _G.CachedActorArray)

    for _, deadBoxActor in pairs(deadBoxes) do
        if slua.isValid(deadBoxActor) and not deadBoxActor.bIsTDSkinApplied then
            local damageCauser = deadBoxActor.DamageCauser
            if damageCauser and damageCauser.PlayerKey == PlayerController.PlayerKey then
                local DeadBoxAvatarComponent = deadBoxActor.DeadBoxAvatarComponent_BP
                if slua.isValid(DeadBoxAvatarComponent) then
                    local currentBoxSkinId = 0
                    if PlayerCharacter.CurrentVehicle and _G.CurrentEquipVehicleID and _G.CurrentEquipVehicleID ~= 0 then
                        currentBoxSkinId = tonumber(tostring(_G.CurrentEquipVehicleID) .. "1") or 0
                    else
                        local currentWeapon = PlayerCharacter:GetCurrentWeapon()
                        if slua.isValid(currentWeapon) and currentWeapon.synData then
                            local weaponSkinData = currentWeapon.synData:Get(7)
                            if weaponSkinData and weaponSkinData.defineID then
                                currentBoxSkinId = weaponSkinData.defineID.TypeSpecificID
                            end
                        end
                    end
                    if currentBoxSkinId ~= 0 then
                        pcall(function()
                            DeadBoxAvatarComponent:ResetItemAvatar()
                            DeadBoxAvatarComponent:PreChangeItemAvatar(currentBoxSkinId)
                            DeadBoxAvatarComponent:SyncChangeItemAvatar(currentBoxSkinId)
                        end)
                    end
                    deadBoxActor.bIsTDSkinApplied = true
                end
            end
        end
    end
end

-- ========================== RISK WARNING ==========================
_G.RiskWarningWidget = nil
local RISK_WARNING_BP = "/Game/UMG/UI_BP/Common/BaseComponent/CommonBaseComponent_TextButton_UIBP.CommonBaseComponent_TextButton_UIBP"

function _G.ShowRiskWarning()
    if _G.RiskWarningWidget and slua.isValid(_G.RiskWarningWidget) then return end
    _G.RiskWarningWidget = nil
    pcall(function()
        local widget = slua.loadUI(RISK_WARNING_BP)
        if not widget or not slua.isValid(widget) then return end
        local hud = require("game_frontend_hud")
        if not (hud and hud.AddToContainer) then return end
        hud.AddToContainer(UIContainers.Top, widget, 10700)

        local WidgetLayoutLibrary = import("WidgetLayoutLibrary")
        local slot = WidgetLayoutLibrary.SlotAsCanvasSlot(widget)
        if slot then
            slot:SetAnchors(FAnchors(0.5, 0, 0.5, 0))
            slot:SetAlignment(FVector2D(0.5, 0))
            slot:SetPosition(FVector2D(0, 0))
            slot:SetSize(FVector2D(180, 30))
        end

        if widget.RichText_Content then
            widget.RichText_Content:SetText("》TG - @SHAYAN_TOOL1《")
            widget.RichText_Content:SetColorAndOpacity(FSlateColor(FLinearColor(0, 0, 0, 1)))
            local fontInfo = widget.RichText_Content.Font
            if fontInfo then
                fontInfo.Size = 14
                fontInfo.TypefaceFontName = "Bold"
                widget.RichText_Content:SetFont(fontInfo)
            end
        end

        if widget.Button_BG then
            widget.Button_BG:SetColorAndOpacity(FLinearColor(1, 0, 0, 0.8))
        end
        if widget.Image_Background then
            widget.Image_Background:SetColorAndOpacity(FLinearColor(1, 0, 0, 0.8))
        end

        widget:SetWidgetVisibility(UEnums.ESlateVisibility.SelfHitTestInvisible)
        _G.RiskWarningWidget = widget
    end)
end

_G.ShowRiskWarning()

-- ========================== AUTO REPORT SYSTEM ==========================
_G.NTH_ModUsersWhitelist = _G.NTH_ModUsersWhitelist or {}

function _G.IsEnemyTarget(localPlayer, character)
    if not slua.isValid(localPlayer) or not slua.isValid(character) then return false end
    if character == localPlayer then return false end
    local localTeam = localPlayer.TeamID or 0
    local targetTeam = character.TeamID or 0
    if localTeam ~= targetTeam then return true end
    return false
end

local AutoReport = {}

local function loadModule(name)
    return package.loaded[name] or require(name)
end

local function isEnabled(key)
    return _G.AK_GetVal(key) == 1
end

local function notify(message)
    if _G.NTHMODNotify then
        _G.NTHMODNotify(message)
    else
        print("[NTHMOD Report] " .. tostring(message))
    end
end

local function submitReport(complaint, name, matchID, uid, openID, source)
    complaint.Submit(
        name, false, false, {4},
        source == "NTHMOD_KillerReport" and "Auto Report Killer" or "Auto Mass Report NTHMOD",
        1, {1, 3, 9}, {}, "", matchID, 18, uid, openID or "", "", {}, 0, 0, 0, 0, 0, 0, false, 0, nil, source, uid, false, 0
    )
end

local MassReport = {
    Queue = {}, IsScanning = false, TimerScan = nil, TimerProcess = nil,
    CurrentMatchID = nil, MatchStartTime = 0, ReportedUIDs = {}
}

function MassReport.ScanServer()
    if not isEnabled("AUTO_MASS_REPORT") then return end
    pcall(function()
        local complaint = loadModule("client.logic.battle.logic_complaint")
        if not complaint then return end
        local matchID = tostring(complaint.GetBattleID() or "LOBBY")
        if matchID == "LOBBY" or matchID == "0" then return end
        if MassReport.CurrentMatchID ~= matchID then
            MassReport.CurrentMatchID = matchID
            MassReport.MatchStartTime = os.time()
            MassReport.ReportedUIDs = {}
            MassReport.Queue = {}
            notify("Detect new match! Waiting for 30 seconds...")
            return
        end
        local elapsed = os.time() - MassReport.MatchStartTime
        if elapsed < 30 then
            if elapsed == 10 or elapsed == 20 then
                notify(string.format("Starting auto-report system (%d sec)", 30 - elapsed))
            end
            return
        end
        local gameplayData = loadModule("GameLua.GameCore.Data.GameplayData")
        local localPlayer = gameplayData.GetPlayerCharacter and gameplayData.GetPlayerCharacter()
        if not slua.isValid(localPlayer) then return end
        local characters = {}
        if gameplayData.GetAllPlayerCharacters then
            characters = gameplayData.GetAllPlayerCharacters()
        elseif gameplayData.GameCharacters then
            for _, character in pairs(gameplayData.GameCharacters) do
                table.insert(characters, character)
            end
        end
        local added = 0
        local skippedVIP = 0
        for _, character in pairs(characters) do
            if slua.isValid(character) and _G.IsEnemyTarget and _G.IsEnemyTarget(localPlayer, character) then
                local name = ""
                local uid = 0
                local openID = ""
                pcall(function()
                    name = character.PlayerName
                        or (type(character.GetPlayerNameSafety) == "function" and character:GetPlayerNameSafety()) or ""
                    local playerState = character.PlayerState
                    if not playerState and type(character.GetPlayerStateSafety) == "function" then
                        playerState = character:GetPlayerStateSafety()
                    end
                    if slua.isValid(playerState) then
                        uid = tonumber(playerState.UID) or tonumber(playerState.PlayerUID) or tonumber(character.PlayerKey) or 0
                        openID = playerState.OpenID or ""
                        if playerState.MLAIDisplayUID and playerState.MLAIDisplayUID > 0 then
                            uid = tonumber(playerState.MLAIDisplayUID)
                        end
                    else
                        uid = tonumber(character.PlayerKey) or 0
                    end
                end)
                if name ~= "" and uid > 0 then
                    local uidKey = tostring(uid)
                    if not MassReport.ReportedUIDs[uidKey] then
                        local isVIP = _G.NTH_ModUsersWhitelist and _G.NTH_ModUsersWhitelist[uidKey]
                        if isVIP then
                            skippedVIP = skippedVIP + 1
                            MassReport.ReportedUIDs[uidKey] = true
                        else
                            local queued = false
                            for _, item in ipairs(MassReport.Queue) do
                                if item.uid == uid then queued = true break end
                            end
                            if not queued then
                                table.insert(MassReport.Queue, { name = name, uid = uid, openid = openID })
                                added = added + 1
                            end
                        end
                    end
                end
            end
        end
        if added > 0 then
            local message = string.format("Added %d enemies to wait-list (Total wait: %d)", added, #MassReport.Queue)
            if skippedVIP > 0 then
                message = message .. string.format(" | SKIP %d VIP NTHMODPUBG", skippedVIP)
            end
            notify(message)
        end
    end)
end

function MassReport.ProcessQueue()
    if not isEnabled("AUTO_MASS_REPORT") then MassReport.Queue = {} return end
    if #MassReport.Queue == 0 then return end
    if os.time() - MassReport.MatchStartTime < 30 then return end
    pcall(function()
        local target = table.remove(MassReport.Queue, 1)
        local complaint = loadModule("client.logic.battle.logic_complaint")
        if not complaint then return end
        local uidKey = tostring(target.uid)
        if MassReport.ReportedUIDs[uidKey] or complaint.IsAlreadyReported(target.name, complaint.GetBattleID()) then return end
        submitReport(complaint, target.name, complaint.GetBattleID(), target.uid, target.openid, "MassReportQueue")
        MassReport.ReportedUIDs[uidKey] = true
        notify(string.format("REPORTED HACKER: %s. REMAINING: %d TARGETS.", target.name, #MassReport.Queue))
    end)
end

function MassReport.Start()
    local ticker = loadModule("common.time_ticker")
    if not ticker or not ticker.AddTimerLoop then return end
    if MassReport.TimerScan then ticker.RemoveTimer(MassReport.TimerScan) end
    if MassReport.TimerProcess then ticker.RemoveTimer(MassReport.TimerProcess) end
    MassReport.TimerScan = ticker.AddTimerLoop(0, MassReport.ScanServer, -1, 30.0)
    MassReport.TimerProcess = ticker.AddTimerLoop(0, MassReport.ProcessQueue, -1, 10.0)
end

local KillerReport = { ReportedCache = {}, MatchID = "", TimerHandle = nil }

function KillerReport.CheckAndReport()
    if not isEnabled("AUTO_REPORT_KILL") then return end
    pcall(function()
        local complaint = loadModule("client.logic.battle.logic_complaint")
        if not complaint then return end
        local matchID = tostring(complaint.GetBattleID() or "LOBBY")
        if matchID == "LOBBY" or matchID == "0" then return end
        if KillerReport.MatchID ~= matchID then
            KillerReport.MatchID = matchID
            KillerReport.ReportedCache = {}
            notify("Match started. Auto-report system start now.")
        end
        if not _G.SubsystemMgr then return end
        local reportSubsystem = _G.SubsystemMgr:Get("ClientReportPlayerSubsystem")
        if not reportSubsystem then return end
        local reportUtils = loadModule("GameLua.Mod.BaseMod.Common.Security.ReportPlayerUtils")
        if not reportUtils then return end
        local nameKey = reportUtils.S_NAME
        local uidKey = reportUtils.S_UID
        local openIDKey = reportUtils.S_OPEN_ID
        local targets = {}
        for _, data in pairs(reportSubsystem:GetFatalDamagerMap(true) or {}) do table.insert(targets, data) end
        for _, data in pairs(reportSubsystem:GetFatalDamagerMap(false) or {}) do table.insert(targets, data) end
        for _, data in pairs(targets) do
            if data and data[nameKey] and data[uidKey] then
                local name = data[nameKey]
                local uid = tonumber(data[uidKey])
                local openID = data[openIDKey] or ""
                local cacheKey = tostring(uid)
                if not KillerReport.ReportedCache[cacheKey] then
                    KillerReport.ReportedCache[cacheKey] = true
                    if _G.NTH_ModUsersWhitelist and _G.NTH_ModUsersWhitelist[cacheKey] then
                        notify("VIP USER " .. name .. " KILLED YOU! SKIP HIM.")
                    else
                        submitReport(complaint, name, matchID, uid, openID, "NTHMOD_KillerReport")
                        notify("YOU HAVE BEEN KILLER, REPORTING TARGET: " .. name)
                    end
                end
            end
        end
    end)
end

function KillerReport.Start()
    local ticker = loadModule("common.time_ticker")
    if not ticker or not ticker.AddTimerLoop then return end
    if KillerReport.TimerHandle then ticker.RemoveTimer(KillerReport.TimerHandle) end
    KillerReport.TimerHandle = ticker.AddTimerLoop(0, KillerReport.CheckAndReport, -1, 1.0)
end

function AutoReport.Start()
    MassReport.Start()
    KillerReport.Start()
end

AutoReport.MassReport = MassReport
AutoReport.KillerReport = KillerReport

AutoReport.Start()

-- ========================== BRPlayerCharacterBase CLASS ==========================
local BRPlayerCharacterBase = {
    ServerRPC = {},
    ClientRPC = {},
    MulticastRPC = {}
}

BRPlayerCharacterBase.ServerRPC.ServerRPC_NearDeathGiveupRescue = { Reliable = true, Params = {} }
BRPlayerCharacterBase.ServerRPC.ServerRPC_CarryDeadBox = { Reliable = true, Params = { UEnums.EPropertyClass.Object } }
BRPlayerCharacterBase.ServerRPC.RPC_Server_GmPlayAction = { Reliable = true, Params = { UEnums.EPropertyClass.Int } }
BRPlayerCharacterBase.MulticastRPC.MulticastRPC_GmPlayAction = { Reliable = true, Params = { UEnums.EPropertyClass.Int } }
BRPlayerCharacterBase.ClientRPC.RPC_Client_SetShouldCheckPassWall = { Reliable = true, Params = { UEnums.EPropertyClass.Bool } }
BRPlayerCharacterBase.ClientRPC.ClientRPC_TriggerHighlightMoment = { Reliable = true, Params = { UEnums.EPropertyClass.UInt32, UEnums.EPropertyClass.UInt32 } }

function BRPlayerCharacterBase:ctor()
    self.bHasShownDevNotice = false
    self.AK_NativeESP_Ready = false
    self.bHiggsTimerSet = false
    self._newWallhackStarted = false
end

function BRPlayerCharacterBase:_PostConstruct()
    BRPlayerCharacterBase.__super._PostConstruct(self)
    self:InitAddSpecialMoveInfo()
    self.bCanNearDeathGiveup = true
    self:StartAdvancedSystems()
end

function BRPlayerCharacterBase:ReceiveBeginPlay()
    BRPlayerCharacterBase.__super.ReceiveBeginPlay(self)
    self:AddControlEvent(self, "MovementModeChangedDelegate", self.HandleOnMovementModeChangedNew, self)
    if self:HasAuthority() and self:CheckAddCheckFallingDistanceComponent() then
        local CheckFallingDistanceComponent_C = import("CheckFallingDistanceComponent")
        if slua.isValid(CheckFallingDistanceComponent_C) and not slua.isValid(self:GetComponentByClass(CheckFallingDistanceComponent_C)) then
            Game:AddComponent(CheckFallingDistanceComponent_C, self, "CheckFallingDistanceComponent")
        end
    end
    if slua.isValid(self.STCharacterMovement) then
        self.STCharacterMovement.bPositiveBlowUp = true
    end
    if self.Role == ENetRole.ROLE_AutonomousProxy then
        self:AddControlEvent(self, "OnPawnStateDisabled", self.OnPawnStateChange, self)
        self:AddControlEvent(self, "OnPawnStateEnabled", self.OnPawnStateChange, self)
        self:AddControlEventConditionOnly(self, "OnAttrChangeEventDelegate", { AttrName = { "bCanSelfRescue" } }, self.CharacterAttrChangeEvent, self)
    end
    if Client then
        GameplayData.AddCharacter(self.Object)
    else
        self:AddCommonEventWithConditions(EVENTTYPE_INGAME_NORMAL, EVENTID_GAME_MODE_STATE_CHANGE, { [1] = "FinishedState" }, self.HandleFinishedState, self)
    end
    EventSystem:postEvent(EVENTTYPE_SINGLETRAINING, EVENTID_CHARACTER_BEGINPLAY, self.Object)
end

function BRPlayerCharacterBase:ReceiveEndPlay(endPlayReason)
    BRPlayerCharacterBase.__super.ReceiveEndPlay(self, endPlayReason)
    if Client and GameplayData.RemoveCharacter then GameplayData.RemoveCharacter(self.Object) end
    if Client then
        pcall(function() if _G.RedBoxOverlay then _G.RedBoxOverlay.Stop() end end)
        pcall(function() if _G.SnapLineOverlay then _G.SnapLineOverlay.Stop() end end)
        pcall(function() if _G.StopSnapLineFastLoop then _G.StopSnapLineFastLoop() end end)
    end
end

function BRPlayerCharacterBase:StartAdvancedSystems()
    if not Client then return end

    if not _G._DistMarkerInitDone then
        InitDistanceMarkerSystem()
        _G._DistMarkerInitDone = true
    end

    if not self.bHiggsTimerSet then
        self.bHiggsTimerSet = true
        self:AddGameTimer(1.0, true, function()
            if not slua.isValid(self.Object) then return end
            pcall(function()
                local lpc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()
                if slua.isValid(lpc) and lpc.HiggsBosonComponent then
                    lpc.HiggsBosonComponent.bMHActive = false
                end
            end)
        end)
    end

    self:AddGameTimer(0.8, true, function()
        if not slua.isValid(self.Object) then return end
        if not (_G.IsLicenseOK and _G.IsLicenseOK()) then return end
        local localPlayer = GameplayData.GetPlayerCharacter()
        if not slua.isValid(localPlayer) then return end

        if self.Object == localPlayer then
            if not localPlayer._bypassActive then
                localPlayer._bypassActive = true
                pcall(function()
                    if _G.WHABypass and _G.WHABypass.Init then
                        _G.WHABypass.Init()
                        _G._WHA_BYPASS_ACTIVE = true
                    end
                end)
                self:AddGameTimer(3.0, false, function()
                    pcall(function()
                        local M = package.loaded["client.slua.logic.common.logic_common_msg_box"]
                               or require("client.slua.logic.common.logic_common_msg_box")
                        M.Show(4, "Bypass Active", "✔ Island bypass activated ✔\n ✔ Play safe • avoid reports ✔\nKill limit 8-15\nTelegram • @SHAYAN_TOOL1", function() end)
                    end)
                end)
            end

            if _G.AK_GetVal("WALLHACK") == 1 then
                if not _G.WH_TIMER then
                    _G.StartNewWallhack()
                end
            else
                if _G.WH_TIMER then
                    _G.StopWallhack()
                end
            end

            pcall(_G.ApplyGraphicsBypass)

            pcall(function() _G.RedBoxScanAndUpdate() end)
            pcall(function() _G.StartSnapLineFastLoop() end)

            self:UpdateIPadView()
            self:UpdateSkin()

            if _G.GTLMODConfig and _G.GTLMODConfig.AimTouchEnable then
                _G.StartAimTouchLoop()
            end

            local mHead, mBody, mLegs, runInject = UpdateMagicBulletHash()
            if _G.GTLMODConfig.CustomMagicBullet then
                pcall(_G.ApplyMagicBullet)
            end

            _G.AKModTickCount = (_G.AKModTickCount or 0) + 1
            if _G.AKModTickCount % 10 == 0 then cleanupDeadEnemyMarks() end

            if not self.AK_NativeESP_Ready then
                pcall(function()
                    local gameplayTools = require("GameLua.Mod.BaseMod.Common.GamePlayTools")
                    local screenMarkConfig = gameplayTools.GetCurrentConfig("ScreenMarkConfig")
                    if screenMarkConfig then
                        if screenMarkConfig[1006] then
                            screenMarkConfig[1006].bBindBlocked = true
                            screenMarkConfig[1006].bBindOutScreen = true
                            screenMarkConfig[1006].MaxWidgetNum = 99
                            screenMarkConfig[1006].MaxShowDistance = 6000000
                        end
                        screenMarkConfig[9999] = distanceMarkerConfig
                    end
                end)
                self.AK_NativeESP_Ready = true
            end

            local enemyCharacters = GameplayData.GetAllPlayerCharacters and GameplayData.GetAllPlayerCharacters() or {}
            local isMapESP = _G.AK_GetVal("ESP_MAP")
            local pc = slua_GameFrontendHUD and slua_GameFrontendHUD:GetPlayerController()

            for _, enemy in pairs(enemyCharacters) do
                if slua.isValid(enemy) and enemy ~= localPlayer and enemy.TeamID ~= localPlayer.TeamID then
                    local isDead = false
                    pcall(function()
                        if type(enemy.IsDead)=="function" then isDead = enemy:IsDead()
                        elseif enemy.bIsDead then isDead = true end
                        if enemy.bHidden or (enemy.Mesh and enemy.Mesh.bHidden) then isDead = true end
                    end)
                    if isDead then goto skip_enemy end

                    processEnemyMapESP(enemy, localPlayer, isMapESP)

                    if _G.AK_GetVal("ESP_HP") == 1 then
                        if not enemy.bHasAKNativeHPBar then
                            pcall(function()
                                enemy.NativeHPBarMark = InGameMarkTools.ClientAddMapMark(1006, FVector(0,0,0), 0, "", 4, enemy)
                                enemy.bHasAKNativeHPBar = true
                            end)
                        end
                    elseif enemy.bHasAKNativeHPBar then
                        pcall(function() InGameMarkTools.ClientRemoveMapMark(enemy.NativeHPBarMark) end)
                        enemy.bHasAKNativeHPBar = false
                    end

                    if _G.AK_GetVal("ESP_BOX") == 1 then
                        pcall(function()
                            if enemy.Replay_IsEnemyFrameUIExisted and not enemy:Replay_IsEnemyFrameUIExisted() then
                                enemy:Replay_CreateEnemyFrameUI(true, true)
                            end
                            if enemy.Replay_SetVisiableOfFrameUI then enemy:Replay_SetVisiableOfFrameUI(true) end
                        end)
                    else
                        pcall(function()
                            if enemy.Replay_SetVisiableOfFrameUI then enemy:Replay_SetVisiableOfFrameUI(false) end
                        end)
                    end

                    if runInject then
                        pcall(_G.ApplyMagicBulletHitbox, enemy, mHead, mBody, mLegs, runInject)
                    end

                    ::skip_enemy::
                end
            end

            if _G.AK_GetVal("AIMBOT") == 1 and (not self._lastAimbotTime or (os.clock() - self._lastAimbotTime) > 2.0) then
                ApplyHardAimbot()
                self._lastAimbotTime = os.clock()
            end
        end
    end)
end

function BRPlayerCharacterBase:UpdateSkin()
    local localPlayer = GameplayData.GetPlayerCharacter()
    if not slua.isValid(localPlayer) then return end

    if _G.FufuModConfig.ModSkin then
        if not _G.TDSkinLoopStarted then
            if _G.InitializeSkinModSystem then _G.InitializeSkinModSystem() end
            if _G.ForceRefreshSkinMaps then _G.ForceRefreshSkinMaps() end
            _G.TDSkinLoopStarted = true
            if not _G.KillInfoCounterHacked and _G.ForceEnableKillCounterUI then _G.ForceEnableKillCounterUI() end
        end

        _G.FufuModState.SkinWasApplied = true
        local curTime = os.clock()
        if not _G.LastSkinUpdateTime or (curTime - _G.LastSkinUpdateTime) > 1.5 then
            _G.LastSkinUpdateTime = curTime
            pcall(function()
                local isAlive = true
                if type(localPlayer.IsAlive) == "function" then
                    isAlive = localPlayer:IsAlive()
                end
                if isAlive then
                    if _G.equip_character_avatar then _G.equip_character_avatar(localPlayer) end
                    if _G.ApplyWeaponSkins then _G.ApplyWeaponSkins(localPlayer) end
                    if _G.ApplyVehicleSkins then _G.ApplyVehicleSkins(localPlayer) end
                    if _G.HandlePetLogic then _G.HandlePetLogic() end
                    if _G.DeadBox_TemperRequest and _G.NeedCheckDeadBoxTimer > 0 then
                        local pc = slua_GameFrontendHUD:GetPlayerController()
                        if slua.isValid(pc) then
                            _G.DeadBox_TemperRequest(pc)
                        end
                    end
                end
            end)
        end
    else
        if _G.FufuModState.SkinWasApplied then
            _G.OutfitMap = {}
            _G.WeaponSkinMap = {}
            _G.VehicleSkinMap = {}
            pcall(function()
                local WeaponManager = localPlayer:GetWeaponManager()
                if slua.isValid(WeaponManager) then
                    for slot = 1, 3 do
                        local Weapon = WeaponManager:GetInventoryWeaponByPropSlot(slot)
                        if slua.isValid(Weapon) and slua.isValid(Weapon.synData) then
                            local WeaponID = Weapon:GetWeaponID()
                            local SkinData = Weapon.synData:Get(7)
                            if SkinData and SkinData.defineID then
                                SkinData.defineID.TypeSpecificID = WeaponID
                                Weapon.synData:Set(7, SkinData)
                                if Weapon.SetWeaponAvatarID then pcall(function() Weapon:SetWeaponAvatarID(WeaponID) end) end
                                if Weapon.DelayHandleAvatarMeshChanged then pcall(function() Weapon:DelayHandleAvatarMeshChanged() end) end
                            end
                        end
                    end
                end
                local Vehicle = localPlayer:GetCurrentVehicle()
                if slua.isValid(Vehicle) then
                    local VehicleAvatar = Vehicle.VehicleAvatar or Vehicle.VehicleAvatarComponent_BP or Vehicle:GetAvatarComponent()
                    if slua.isValid(VehicleAvatar) and type(VehicleAvatar.GetDefaultAvatarID) == "function" then
                        local defId = VehicleAvatar:GetDefaultAvatarID()
                        if VehicleAvatar.ChangeItemAvatar then VehicleAvatar:ChangeItemAvatar(defId, true) end
                    end
                end
                if localPlayer.AvatarComponent2 and type(localPlayer.AvatarComponent2.OnRep_BodySlotStateChanged) == "function" then
                    localPlayer.AvatarComponent2:OnRep_BodySlotStateChanged()
                end
            end)
            _G.FufuModState.SkinWasApplied = false
        end
        _G.TDSkinLoopStarted = false
    end
end

function BRPlayerCharacterBase:UpdateIPadView()
    local bAiming = false
    pcall(function() bAiming = self.Object.bIsWeaponAiming or false end)
    if bAiming then return end

    local tppCam = self.Object.ThirdPersonCameraComponent
    local fppCam = self.Object.FirstPersonCameraComponent

    local customFOV = 120
    if _G.GTLMODState and _G.GTLMODState.CustomTextData and _G.GTLMODState.CustomTextData.IpadViewFOV then
        customFOV = tonumber(_G.GTLMODState.CustomTextData.IpadViewFOV) or 120
    end

    if _G.AK_GetVal("IPAD_VIEW") == 1 then
        if slua.isValid(tppCam) and customFOV > 0 then tppCam:SetFieldOfView(customFOV) end
        if slua.isValid(fppCam) and customFOV > 0 then fppCam:SetFieldOfView(customFOV) end
    else
        if slua.isValid(tppCam) then tppCam:SetFieldOfView(80) end
        if slua.isValid(fppCam) then fppCam:SetFieldOfView(80) end
    end
end

-- ========================== SETTINGS MENU ==========================
local function initModMenuTab()
    if _G.ModMenuInitialized then return end
    _G.ModMenuInitialized = true

    local SPD = require("client.logic.NewSetting.SettingPageDefine")
    local SCL = require("client.logic.NewSetting.SettingCatalog")
    local AM = require("client.slua.umg.NewSetting.Item.AliasMap")
    if not SPD or not SCL or not AM then return end
    if SPD.FMMenu then return end

    local function Tog(key, text, featureId)
        return {
            Key = key,
            UI = AM.TitleSwitcher,
            Text = text,
            GetFunc = function() return _G.AK_GetVal(featureId) == 1 end,
            SetFunc = function(self, v) _G.AK_SetVal(featureId, v and 1 or 0); return true end
        }
    end

    local function SkinSlider(key, text, minV, maxV, getter, setter)
        return {
            Key = key, UI = AM.Slider, Text = text,
            Min = minV, Max = maxV, Step = 1, IsPercent = false,
            GetFunc = getter,
            SetFunc = function(self, v) setter(v); return true end
        }
    end

    local tabFeatures = {
        Key = "Tab_FM_Features", Text = "Features",
        Stack = {
            { UI = AM.Title, Text = "==== FEATURE SETTINGS ====" },
            Tog("FM_ESP_HP", "ESP Health Bar", "ESP_HP"),
            Tog("FM_ESP_BOX", "ESP Box", "ESP_BOX"),
            Tog("FM_ESP_MAP", "ESP Jarak", "ESP_MAP"),
            Tog("FM_WALLHACK", "Wallhack", "WALLHACK"),
        }
    }

    local tabFikturPlus = {
        Key = "Tab_FM_FikturPlus", Text = "FIKTUR +",
        Stack = {
            { UI = AM.Title, Text = "==== GRAPHICS BYPASS ====" },
            Tog("FM_BLACK_SKY",  "Black Sky (Langit Hitam)",       "BLACK_SKY"),
            Tog("FM_NO_FOG",     "Remove Fog (Hilangkan Kabut)",   "NO_FOG"),
            Tog("FM_UNLOCK_FPS", "Unlock 165 FPS",                 "UNLOCK_FPS"),

            { UI = AM.Title, Text = "==== IPAD VIEW ====" },
            {
                Key = "FM_IPAD_VIEW_TGL",
                UI = AM.TitleSwitcher,
                Text = "iPad View (Custom FOV)",
                GetFunc = function() return _G.AK_GetVal("IPAD_VIEW") == 1 end,
                SetFunc = function(self, v)
                    _G.AK_SetVal("IPAD_VIEW", v and 1 or 0)
                    return true
                end
            },
            {
                Key = "FM_Ipad_FOV",
                UI = AM.Slider,
                Text = "   FOV Angle (80-180)",
                Min = 1, Max = 100, Step = 1,
                GetFunc = function()
                    return (_G.GTLMODState.CustomTextData.IpadViewFOV or 120) - 80
                end,
                SetFunc = function(self, v)
                    _G.GTLMODState.CustomTextData.IpadViewFOV = 80 + v
                    return true
                end
            },
            { UI = AM.Title, Text = "Tips: FOV 120-140 aman & nyaman" },
        }
    }

    SPD.FMMenu = {
    Key = "FMMenu",
    Text = "VIP SHAYAN MOD ",
    UIKey = "Setting_Page_Privacy",
    Category = { tabFeatures, tabFikturPlus, tabMagicBullet, tabSkin, tabAimbotUR }
}

    if type(SCL) == "table" then
        table.insert(SCL, SPD.FMMenu)
    else
        _G.SettingCatalog = _G.SettingCatalog or {}
        table.insert(_G.SettingCatalog, SPD.FMMenu)
    end

    local UIM = _G.UIManager
    if UIM and not UIM._IsModMenuHooked then
        local old = UIM.ShowUI
        UIM.ShowUI = function(uiConfig, ...)
            local args = {...}
            if uiConfig and uiConfig.keyName and string.find(string.lower(uiConfig.keyName), "setting") then
                local category = args[1]
                if type(category) == "table" then
                    local has = false
                    for _, p in ipairs(category) do
                        if type(p) == "table" and p.Key == "FMMenu" then has = true end
                    end
                    if not has then table.insert(category, SPD.FMMenu) end
                end
            end
            return old(uiConfig, table.unpack(args, 1, select('#', ...)))
        end
        UIM._IsModMenuHooked = true
    end
end

pcall(initModMenuTab)

-- ========================================== 
-- WATERMARK PERMANEN
-- ==========================================
pcall(function()
    local IPS = require("GameLua.Mod.Library.Client.UI.IngamePhoneStateUI")
    if IPS and IPS.__inner_impl then
        local o = IPS.__inner_impl.UpdateArtQualityUI
        IPS.__inner_impl.UpdateArtQualityUI = function(self, _, _)
            if self.UIRoot and self.UIRoot.TextBlock_quality then
                self.UIRoot.TextBlock_quality:SetText("SHAYAN PAID")
                self.UIRoot.TextBlock_quality:SetColorAndOpacity(FSlateColor(FLinearColor(1, 1, 0, 1)))
            end
        end
    end
end)

-- ============================================================
-- AUTO FEEDBACK SYSTEM (Telegram) - ALL RANKS SUPPORTED
-- ============================================================
local AutoFeedback = {
	Config = {
		ServerURL = "shaya-lua-fbn.shadowcheatss-1.workers.dev",
		TestMode = false
	},
	Hooked = false
}

local function AF_Log(message)
	print(string.format("[SHAYAN][%s] %s", os.date("%H:%M:%S"), tostring(message)))
end

local function AF_Notify(message)
	if _G.SRCHUBNotify then
		pcall(_G.SRCHUBNotify, message)
	end
end

local function AF_GetModule(name, allowRequire)
	local loaded = package and package.loaded and package.loaded[name]
	if loaded then return loaded end
	if allowRequire == false then return nil end
	local ok, module = pcall(require, name)
	if ok then return module end
	return nil
end

local function AF_AddTimerOnce(delay, callback)
	local ticker = AF_GetModule("common.time_ticker")
	if ticker and type(ticker.AddTimerOnce) == "function" then
		ticker.AddTimerOnce(delay, callback)
		return true
	end
	return false
end

local function AF_Base64Encode(data)
	if type(data) ~= "string" or #data == 0 then return "" end
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local output = {}
	local outputIndex = 0
	local index = 1
	while index <= #data - 2 do
		local a, b, c = string.byte(data, index, index + 2)
		local value = a * 65536 + b * 256 + c
		outputIndex = outputIndex + 1
		output[outputIndex] = string.char(
			string.byte(alphabet, math.floor(value / 262144) + 1),
			string.byte(alphabet, math.floor(value / 4096) % 64 + 1),
			string.byte(alphabet, math.floor(value / 64) % 64 + 1),
			string.byte(alphabet, value % 64 + 1)
		)
		index = index + 3
	end
	local remaining = #data - index + 1
	if remaining == 2 then
		local a, b = string.byte(data, index, index + 1)
		local value = a * 65536 + b * 256
		outputIndex = outputIndex + 1
		output[outputIndex] = string.char(
			string.byte(alphabet, math.floor(value / 262144) + 1),
			string.byte(alphabet, math.floor(value / 4096) % 64 + 1),
			string.byte(alphabet, math.floor(value / 64) % 64 + 1),
			string.byte("=")
		)
	elseif remaining == 1 then
		local value = string.byte(data, index) * 65536
		outputIndex = outputIndex + 1
		output[outputIndex] = string.char(
			string.byte(alphabet, math.floor(value / 262144) + 1),
			string.byte(alphabet, math.floor(value / 4096) % 64 + 1),
			string.byte("="),
			string.byte("=")
		)
	end
	return table.concat(output)
end

local function AF_UrlEncode(value)
	if value == nil then return nil end
	value = tostring(value):gsub("\n", "\r\n")
	value = value:gsub("([^A-Za-z0-9 %-%_%.%~])", function(character)
		return string.format("%%%02X", string.byte(character))
	end)
	value = value:gsub(" ", "+")
	return value
end

local function AF_ReadFile(path)
	local file = io.open(path, "rb")
	if not file then return "" end
	local data = file:read("*a") or ""
	file:close()
	return data
end

local function AF_RemoveFile(path)
	pcall(os.remove, path)
end

local function AF_GetRankName(rank)
	if rank < 1700 then return "Bronze"
	elseif rank < 2200 then return "Silver"
	elseif rank < 2700 then return "Gold"
	elseif rank < 3200 then return "Platinum"
	elseif rank < 3700 then return "Diamond"
	elseif rank < 4200 then return "Crown"
	elseif rank < 4700 then return "Ace"
	elseif rank < 5200 then return "Ace Master"
	elseif rank < 5600 then return "Ace Dominator"
	end
	return "Conqueror"
end

local FeedbackCaptionTemplate = "<b>OWNER_+92 [ 03319741588 ]</b>\n<pre>\n🥷Player - %s\n🔖UID    - %s\n🕛Time   - %s\n☠️Kills  - %d\n🥇Rank   - %s\n</pre>\n[ ACTIVE-PREMIUM ]\n<b>Owner: @SHAYAN_TOOL1</b>"

function AutoFeedback.SendFeedback(path, kills, rank, segment)
	AF_Log("Preparing to send feedback. Screenshot: " .. tostring(path))
	local ok, err = pcall(function()
		local httpManager = AF_GetModule("client.slua.logic.http.http_manager")
		if not httpManager or type(httpManager.Post) ~= "function" then
			AF_Log("HTTP manager is unavailable.")
			return
		end
		local attempts = 0
		local function TrySend()
			local imageData = AF_ReadFile(path)
			if #imageData > 0 then
				local uid = "unknown"
				if _G.DataMgr and _G.DataMgr.roleData and _G.DataMgr.roleData.uid then
					uid = tostring(_G.DataMgr.roleData.uid)
				elseif _G._KONG_UK then
					uid = tostring(_G._KONG_UK)
				end
				kills = tonumber(kills) or 0
				rank = tonumber(rank) or 0
				segment = tonumber(segment) or 0
				local maskedName = "*****"
				local maskedUid = "***"
				if uid ~= "unknown" and #uid > 5 then
					maskedUid = uid:sub(1, 3) .. "***" .. uid:sub(-2)
				end
				local caption = string.format(
					FeedbackCaptionTemplate,
					maskedName,
					maskedUid,
					os.date("%H:%M:%S %d/%m/%Y"),
					kills,
					AF_GetRankName(rank)
				)
				local encodedImage = AF_Base64Encode(imageData)
				encodedImage = encodedImage:gsub("%+", "%%2B")
				encodedImage = encodedImage:gsub("/", "%%2F")
				encodedImage = encodedImage:gsub("=", "%%3D")
				AF_Notify("[SRC_HUB] Uploading Top 1 screenshot to VIP Server...")
				local body = "base64_image=" .. encodedImage
					.. "&caption=" .. AF_UrlEncode(caption)
					.. "&bot_token=" .. AF_UrlEncode("8883599345:AAFO3RsUUwp3Uwj484kNU42IMwBk-Ug9w-U")
					.. "&chat_id=" .. AF_UrlEncode("-1004439651956")
				httpManager:Post(
					AutoFeedback.Config.ServerURL,
					{["Content-Type"] = "application/x-www-form-urlencoded"},
					body,
					nil,
					function(success, _, response, errorMessage)
						if success and response and tostring(response):find('"status":%s*true') then
							AF_Notify("[SRC_HUB] Successfully sent! (Kills: " .. tostring(kills) .. ")")
						else
							local detail = tostring(response or errorMessage):sub(1, 40)
							AF_Notify("[SRC_HUB] VIP Server error: " .. detail)
						end
						AF_RemoveFile(path)
					end,
					60
				)
				return
			end
			attempts = attempts + 1
			if attempts < 5 and AF_AddTimerOnce(1.0, TrySend) then
				return
			end
			AF_Notify("[SRC_HUB] Screenshot capture failed!")
			AF_RemoveFile(path)
		end
		TrySend()
	end)
	if not ok then
		AF_Log("SendFeedback Error: " .. tostring(err))
	end
end

local AF_HudNames = {
	"BattleChat_UIBP","Chat_UIBP","ChatMsg_UIBP","TeamAvatar_UIBP","Team_UIBP",
	"VoiceChat_UIBP","MiniMap_UIBP","Bag_UIBP","PickUp_UIBP","PickUpList_UIBP",
	"SystemChat_UIBP","InGameChat_UIBP","InGameChatPanel_UIBP","KillFeed_UIBP",
	"Elimination_UIBP","ChatHUD_UIBP","ChatPanel_UIBP","MainHUD_UIBP","BattleHUD_UIBP"
}

local function AF_GetRankAndSegment()
	local rank = 0
	local segment = 0
	pcall(function()
		local battleResult = _G.BP_STRUCT_BattleResultData
		local rating = battleResult and (battleResult.rating or battleResult.BP_STRUCT_BTRating)
		if rating then
			rank = tonumber(rating.rank_rating) or 0
			segment = tonumber(rating.new_segment) or 0
		end
		if rank == 0 then
			local funcUtil = AF_GetModule("common.func_util")
			local roleData = _G.DataMgr and _G.DataMgr.roleData
			if funcUtil and type(funcUtil.GetCurMaxSegementLevel) == "function"
				and roleData and roleData.allzoneSegment then
				segment = tonumber(funcUtil.GetCurMaxSegementLevel(roleData.allzoneSegment)) or 0
			end
			if roleData and roleData.segment_rating then
				for _, value in pairs(roleData.segment_rating) do
					if type(value) == "table" then
						for _, nestedValue in pairs(value) do
							if type(nestedValue) == "number" and nestedValue > rank then
								rank = nestedValue
							end
						end
					elseif type(value) == "number" and value > rank then
						rank = value
					end
				end
			end
		end
	end)
	return rank, segment
end

local function AF_CreateHudController()
	local hidden = {}
	local function SetHidden(hide)
		local UIManager = _G.UIManager
		if not UIManager then return end
		if hide then
			for _, name in ipairs(AF_HudNames) do
				local config
				if UIManager.UI_Config_InGame and UIManager.UI_Config_InGame[name] then
					config = UIManager.UI_Config_InGame[name]
				elseif UIManager.UI_Config and UIManager.UI_Config[name] then
					config = UIManager.UI_Config[name]
				end
				if config then
					local view = type(UIManager.GetUI) == "function" and UIManager.GetUI(config) or nil
					if view then
						pcall(function()
							if type(view.SetVisibility) == "function" then
								view:SetVisibility(2)
							elseif view.UIRoot and type(view.UIRoot.SetVisibility) == "function" then
								view.UIRoot:SetVisibility(2)
							elseif type(UIManager.HideUI) == "function" then
								UIManager.HideUI(config)
							elseif type(UIManager.CloseUI) == "function" then
								UIManager.CloseUI(config)
							end
						end)
						table.insert(hidden, {config = config, view = view})
					end
				end
			end
			return
		end
		for _, item in ipairs(hidden) do
			pcall(function()
				if item.view and type(item.view.SetVisibility) == "function" then
					item.view:SetVisibility(0)
				elseif item.view and item.view.UIRoot and type(item.view.UIRoot.SetVisibility) == "function" then
					item.view.UIRoot:SetVisibility(0)
				elseif type(UIManager.ShowUI) == "function" then
					UIManager.ShowUI(item.config)
				end
			end)
		end
		hidden = {}
	end
	return SetHidden
end

local function AF_GetScreenshotDirectory()
	local directories = {}
	local home = os.getenv("HOME")
	if home and home ~= "" then
		table.insert(directories, home .. "/Documents/ShadowTrackerExtra/Saved/")
	end
	local packages = {"com.tencent.ig","com.vng.pubgmobile","com.pubg.krmobile","com.rekoo.pubgm","com.pubg.imobile"}
	for _, packageName in ipairs(packages) do
		table.insert(directories,
			"/storage/emulated/0/Android/data/" .. packageName
			.. "/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/")
	end
	local selected = directories[1]
	for _, directory in ipairs(directories) do
		local testPath = directory .. "t.tmp"
		local file = io.open(testPath, "w")
		if file then
			file:close()
			os.remove(testPath)
			selected = directory
			break
		end
	end
	return selected
end

local function AF_CaptureAndSend(kills, rank, segment, restoreHud)
	local restored = false
	local function RestoreHudOnce()
		if not restored then
			restored = true
			restoreHud(false)
		end
	end
	local ScreenshotMaker = import("ScreenshotMaker")
	if not ScreenshotMaker then RestoreHudOnce(); return end
	local directory = AF_GetScreenshotDirectory()
	if not directory then RestoreHudOnce(); return end
	local path = directory .. string.format("kongwin_%s.jpg", os.time())
	local uiUtil = AF_GetModule("client.common.ui_util")
	local gameInstance = uiUtil and uiUtil.GetGameInstance and uiUtil.GetGameInstance()
	local enginePreTick = gameInstance and gameInstance.EnginePreTick
	if not enginePreTick or type(enginePreTick.Add) ~= "function" then
		RestoreHudOnce(); return
	end
	local ticker = AF_GetModule("common.time_ticker")
	if not ticker or type(ticker.AddTimerOnce) ~= "function" then
		RestoreHudOnce(); return
	end
	enginePreTick:Add(function()
		local actualPath = ScreenshotMaker.MakePictureByName(path, true)
		if type(enginePreTick.Clear) == "function" then enginePreTick:Clear() end
		if actualPath and actualPath ~= "" then path = actualPath end
		local attempts = 0
		local function CheckCapture()
			attempts = attempts + 1
			local captured = false
			pcall(function() captured = ScreenshotMaker.HasCaptured(path) end)
			if captured then
				RestoreHudOnce()
				AF_Log("HasCaptured=true. Flushing to disk via ResizePicture...")
				pcall(ScreenshotMaker.ResizePicture, path, 0.9, path)
				ticker.AddTimerOnce(2.0, function()
					if #AF_ReadFile(path) > 0 then
						AutoFeedback.SendFeedback(path, kills, rank, segment)
					else
						AF_Notify("[SRC_HUB] iOS image read error!")
					end
				end)
			elseif attempts < 15 then
				ticker.AddTimerOnce(1, CheckCapture)
			else
				RestoreHudOnce()
				AF_Notify("[SRC_HUB] Screenshot capture failed!")
			end
		end
		ticker.AddTimerOnce(1, CheckCapture)
	end)
end

function AutoFeedback.ProcessWin(kills)
	kills = tonumber(kills) or 0
	local rank, segment = AF_GetRankAndSegment()
	-- ✅ ALL RANKS SUPPORTED - Sirf kills check (kills > 0)
	if kills <= 0 then
		AF_Log(string.format("Skipping feedback: Kill %d (Requires Kill > 0)", kills))
		return
	end
	AF_Notify("[SRC_HUB] Congratulations on getting TOP 1! Rank: " .. AF_GetRankName(rank))
	local setHudHidden = AF_CreateHudController()
	setHudHidden(true)
	local ok, err = pcall(AF_CaptureAndSend, kills, rank, segment, setHudHidden)
	if not ok then
		setHudHidden(false)
		AF_Log("ProcessWin Error: " .. tostring(err))
	end
end

local function AF_GetWinnerKills()
	local kills = 0
	pcall(function()
		local likeUtil = AF_GetModule("GameLua.Mod.BaseMod.Client.Like.IngameLikeUtilClient")
		if likeUtil and type(likeUtil.GetMyPlayerState) == "function" then
			local playerState = likeUtil.GetMyPlayerState()
			if playerState and playerState.Kills then
				kills = tonumber(playerState.Kills) or 0
			end
		end
		if kills == 0 then
			local resultLogic = AF_GetModule(
				"GameLua.Mod.BaseMod.Client.BattleResult.BattleResultData.BattleResultDataLogic",
				false
			)
			if resultLogic and type(resultLogic.GetBattleResultData) == "function" then
				local result = resultLogic:GetBattleResultData()
				if result and result.BP_mykill then
					kills = tonumber(result.BP_mykill) or 0
				end
			end
		end
	end)
	return kills
end

local function AF_TryInstallHook()
	pcall(function()
		local UIManager = _G.UIManager
		if not UIManager or not UIManager.ShowUI then return end
		if UIManager.__SRCHUBHooked then
			UIManager.__SRCHUBHooked = false
		end
		AF_Log("Hooking UIManager.ShowUI for in-game Winner UI...")
		local originalShowUI = UIManager.ShowUI
		UIManager.ShowUI = function(config, params, ...)
			local result = originalShowUI(config, params, ...)
			pcall(function()
				-- ✅ STRONG WINNER DETECTION - Chicken Dinner Fix
				if not params then return end

				local isWinner = params.Reason == "win"
					or params.ShowedWinLogo == true
					or params.IsWin == true
					or params.IsWinner == true
					or params.bWin == true
					or params.Win == true

				if not isWinner then return end

				local kills = AF_GetWinnerKills()
				if not AF_AddTimerOnce(2, function() AutoFeedback.ProcessWin(kills) end) then
					AutoFeedback.ProcessWin(kills)
				end
			end)
			return result
		end
		-- UIManager.__SRCHUBHooked = true
		AF_Log("UIManager Hook installed successfully.")
	end)
end

function AutoFeedback.Install()
	AF_Log("Installing Pro system (Telegram)...")
	if AutoFeedback.Config.TestMode then
		pcall(function()
			AF_AddTimerOnce(5.0, function() AutoFeedback.ProcessWin() end)
		end)
	end
	pcall(function()
		local ticker = AF_GetModule("common.time_ticker")
		if ticker and type(ticker.AddTimer) == "function" then
			ticker.AddTimer(3.0, AF_TryInstallHook)
		else
			AF_TryInstallHook()
		end
	end)
end

_G.GODxRJ_AutoFeedbackRecovered = AutoFeedback
AutoFeedback.Install()
-- ============================================================
-- END AUTO FEEDBACK SYSTEM
-- ============================================================

-- ===================================================================================
-- ==================== TRIGGER ONLINE LICENSE =======================================
-- ===================================================================================
pcall(function()
    local ticker = require("common.time_ticker")
    local function try_license()
        if _G.License_Validate then
            _G.License_Validate(function(valid)
                if valid then
                    _G._MOD_EXPIRED = false
                    print("[MAIN] License validated. Mods unlocked.")
                    pcall(function()
                        if _G.InitializeAutoHeadHooks then _G.InitializeAutoHeadHooks() end
                    end)
                else
                    _G._MOD_EXPIRED = true
                    print("[MAIN] License not validated. Mods remain locked.")
                end
            end)
        end
    end
    if ticker and ticker.AddTimerOnce then
        ticker.AddTimerOnce(1.0, try_license)
    else
        try_license()
    end
end)

-- ===================================================================================
-- ================== THE RETURN SECTION RETAINS THE ORIGINAL CODE. ===================
-- ===================================================================================
local class = require("class")
local CharacterBase = require("GameLua.GameCore.Framework.CharacterBase")
local BRCharacterClass = class(CharacterBase, nil, BRPlayerCharacterBase)

return require("combine_class").DeclareFeature(BRCharacterClass, {
    { SkyTransition = "GameLua.Mod.BaseMod.Gameplay.Feature.SkyControl.PlayerCharacterSkyTransitionFeature" },
    { CarryDeadBoxFeature = "GameLua.Mod.Library.GamePlay.Feature.CarryDeadBoxFeature" },
    { SpecialSuitFeature = "GameLua.Mod.Library.GamePlay.Feature.SpecialSuitFeature" },
    { TeleportPawnFeature = "GameLua.Mod.Library.GamePlay.Feature.TeleportPawnFeature" },
    { LifterControl = "GameLua.Mod.BaseMod.Gameplay.Feature.Player.CharacterLifterControlFeature" },
    { FinalKillEffect = "GameLua.Mod.BaseMod.Gameplay.Feature.Player.PlayerCharacterFinalKillEffectFeature" },
    { CampFeature = "GameLua.Mod.BaseMod.GamePlay.Feature.Camp.PlayerCharacterCampFeature" },
    { BuildSkateFeature = "GameLua.Mod.BaseMod.GamePlay.Feature.PlayerCharacterBuildVehicleFeature" },
    { CommonBornlandTransformFeature = "GameLua.Mod.BaseMod.GamePlay.Feature.HeroPropFeature.CommonBornlandTransformFeature" },
    { ParachuteFormation = "GameLua.Mod.BaseMod.Gameplay.Feature.ParachuteFormationFeature" }
}, "BRPlayerCharacterBase")