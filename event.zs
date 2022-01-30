//import
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.IPlayerEvent;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;
import crafttweaker.event.PlayerRespawnEvent;
import crafttweaker.event.PlayerSmeltedEvent;
import crafttweaker.event.PlayerCraftedEvent;
import crafttweaker.event.PlayerBreakSpeedEvent;
import crafttweaker.event.PlayerSleepInBedEvent;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.world.IWorld;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.event.BlockPlaceEvent;

/**
＝＝＝＝＝＝＝＝
終末クラフト
＝＝＝＝＝＝＝＝

説明：
太陽が膨張したまに太陽光によるダメージを
受け続けるようになってしまう

必要mod：（最新バージョンで問題なし）
1.CraftTweaker
2.JEI

紳士ルール：
リログをしない（金リンゴが無限に手に入ってしまうため）

ルール：
1.自然回復がOFF
2.常に昼 
3.最初に金リンゴが6個支給される
4.終末回避時計を作った時点でクリア。
5.太陽光により全て明るい
6.ネザー等のディメンション関係なしにダメージを受ける

**/
//終末時計
val End_Clock as IItemStack = <minecraft:skull:3>.withTag({SkullOwner: {Id: "8b0e7000-1c51-4ff6-b719-04c4c4111713", Properties: {textures: [{Value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTAwZTc1YTNiNWJiMjYwNzQwY2RjYWY0OWQ2YmQ5MmU3NjZiMTBkNzM0OTAxODY1M2E5OTI0Y2ViODcxNTI2NSJ9fX0="}]}}, ench: [{lvl: 5 as short, id: 16 as short}], RepairCost: 1, HideFlags: 35, display: {Lore: ["§7全ての権限を持った者がこのアイテムを設置することで", "§7終末を回避することができる"], Name: "§5§l終末回避時計"}, AttributeModifiers: [{UUIDMost: 712004297547663662 as long, UUIDLeast: -8837016181030637800 as long, Amount: 30.0, Slot: "mainhand", AttributeName: "generic.attackDamage", Operation: 0, Name: "generic.attackDamage"}]});
//JEI用
val End_Clock_JEI = <minecraft:skull:3>.withTag({SkullOwner: {Id: "8b0e7000-1c51-4ff6-b719-04c4c4111713", Properties: {textures: [{Value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTAwZTc1YTNiNWJiMjYwNzQwY2RjYWY0OWQ2YmQ5MmU3NjZiMTBkNzM0OTAxODY1M2E5OTI0Y2ViODcxNTI2NSJ9fX0="}]}}, ench: [{lvl: 5 as short, id: 16 as short}], RepairCost: 1, HideFlags: 35, display: {Lore: ["§7全ての権限を持った者がこのアイテムを設置することで", "§7終末を回避することができる", "§aレシピ：", "§6■ : §7ブレイズパウダー", "§b■ : §7ダイヤモンドブロック", "§f■ : クォーツブロック", "§c■ : §f金ブロック", "", "§6█§f█§6█", "§c█§b█§c█", "§6█§f█§6█"], Name: "§5§l終末回避時計"}, AttributeModifiers: [{UUIDMost: 712004297547663662 as long, UUIDLeast: -8837016181030637800 as long, Amount: 30.0, Slot: "mainhand", AttributeName: "generic.attackDamage", Operation: 0, Name: "generic.attackDamage"}]});

//ログイン時に処理
events.onPlayerLoggedIn(function(event as crafttweaker.event.PlayerLoggedInEvent) {
    event.player.addPotionEffect(<potion:minecraft:night_vision>.makePotionEffect(10000000, 0));
    event.player.executeCommand("gamerule commandBlockOutput false");
    event.player.executeCommand("gamerule sendCommandFeedback false");
    event.player.executeCommand("gamerule doDaylightCycle false");
    event.player.executeCommand("gamerule doWeatherCycle false");
    event.player.executeCommand("gamerule naturalRegeneration false");
    event.player.executeCommand("time set day");
    event.player.executeCommand("give @p minecraft:golden_apple 6");
    event.player.executeCommand('tellraw @a ["",{"text":"===============","color":"gray"},{"text":"\n"},{"text":"\u7d42\u672b\u30af\u30e9\u30d5\u30c8","color":"dark_purple"},{"text":"\n"},{"text":"===============","color":"gray"},{"text":"\n\u8003\u6848/\u4f5c\u6210\uff1aStop__Internet\n\u57fa\u672c\u30eb\u30fc\u30eb\uff1a\n\uff11\uff1a\u4f53\u529b\u304c\u81ea\u7136\u56de\u5fa9\u3057\u306a\u3044\u3002\n\uff12\uff1a\u591c\u304c\u6765\u306a\u3044\u3002\n\uff13\uff1a\u521d\u671f\u306b\u91d1\u30ea\u30f3\u30b4\u304c6\u500b\u652f\u7d66\u3055\u308c\u308b\u3002\n\uff14\uff1a\u592a\u967d\u5149\u306b\u3088\u308b\u30c0\u30e1\u30fc\u30b8\u3092\u305f\u307e\u306b\u3046\u3051\u308b\u3002\n  \uff08\u30cd\u30b6\u30fc\u3067\u3082\u5f71\u97ff\u306f\u53d7\u3051\u308b\uff09\n\uff15\uff1a\u96e8\u304c\u964d\u3089\u306a\u3044\u3002\n\uff16\uff1a\u592a\u967d\u5149\u306b\u3088\u3063\u3066\u5e38\u306b\u5468\u308a\u304c\u660e\u308b\u304f\u306a\u308b\u3002\n\n\u30af\u30ea\u30a2\u6761\u4ef6\uff1a\n\u7d42\u672b\u56de\u907f\u6642\u8a08\u306e\u4f5c\u6210\n==========================="}]');
});

//太陽光ダメージの処理
events.onPlayerTick(function(event as crafttweaker.event.PlayerTickEvent){
	if(event.player.world.time % 3000 == 0){
        event.player.addPotionEffect(<potion:minecraft:instant_damage>.makePotionEffect(20, 0));
        event.player.addPotionEffect(<potion:minecraft:night_vision>.makePotionEffect(1000, 0));
        event.player.sendChat("太陽光によるダメージを受けた!!");
    	}
});
//死んだらスペククテイター
events.onPlayerRespawn(function (event as crafttweaker.event.PlayerRespawnEvent) {
    event.player.executeCommand("gamemode spectator @p");
        } 
);

//レシピ
recipes.remove(<minecraft:clock>);
recipes.addShaped(End_Clock, 
[[<minecraft:blaze_powder>, <minecraft:quartz_block>, <minecraft:blaze_powder>],
[<minecraft:gold_block>, <minecraft:diamond_block>, <minecraft:gold_block>], 
[<minecraft:blaze_powder>, <minecraft:quartz_block>, <minecraft:blaze_powder>]]);

//終末時計の動作
events.onBlockPlace(function (event as crafttweaker.event.BlockPlaceEvent){
        if(End_Clock) {
        event.player.executeCommand("gamemode creative @a");
        event.player.executeCommand('tellraw @a ["",{"text":"===============","color":"gray"},{"text":"\n"},{"text":"\u7d42\u672b\u304c\u56de\u907f\u3055\u308c\u305f\uff01","color":"green"},{"text":"\n"},{"text":"===============","color":"gray"}]');
        event.player.executeCommand("gamerule commandBlockOutput true");
        event.player.executeCommand("gamerule sendCommandFeedback true");
        event.player.executeCommand("gamerule doDaylightCycle true");
        event.player.executeCommand("gamerule doWeatherCycle true");
        event.player.executeCommand("gamerule naturalRegeneration true");
        events.clear();
        }
});
//JEI
mods.jei.JEI.addItem(End_Clock_JEI);