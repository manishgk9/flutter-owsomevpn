import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:owsomevpn/addmob/add_mob_helper.dart';

class AdController extends GetxController {
  late BannerAd bannerAd;
  var isBannerAdLoaded = false.obs;

  late InterstitialAd interstitialAd;
  var isInterstitialAdLoaded = false.obs;

  RewardedAd? rewardedAd; // Use nullable RewardedAd
  var isRewardedAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBannerAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  // Load the Banner Ad
  void _loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AddMobHelper.bannerIdDetails,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerAdLoaded.value = true;
          print("banner ad is loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          isBannerAdLoaded.value = false;
          print('BannerAd failed to load: $error');
        },
      ),
    );
    bannerAd.load();
  }

  // Load the Interstitial Ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AddMobHelper
          .interstitialAddDetails, // Replace with your real interstitial ad unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded.value = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          isInterstitialAdLoaded.value = false;
        },
      ),
    );
  }

  // Show the Interstitial Ad
  void showInterstitialAd() {
    if (isInterstitialAdLoaded.value) {
      interstitialAd.show();
      _loadInterstitialAd(); // Load a new interstitial ad after showing the current one
    }
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AddMobHelper.rewardedAdDetails,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          isRewardedAdLoaded.value = true;
          rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              rewardedAd = null;
              _loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          isRewardedAdLoaded.value = false;
        },
      ),
    );
  }

  showRewardedAd() {
    if (isRewardedAdLoaded.value) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView, RewardItem) {},
      );
      isRewardedAdLoaded.value = false; // Reset the state after showing the ad
    }
  }

  @override
  void onClose() {
    bannerAd.dispose();
    interstitialAd.dispose();
    rewardedAd?.dispose();
    super.onClose();
  }
}
