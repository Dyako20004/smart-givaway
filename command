messages: {
          giveaway: "🎉🎉 **GIVEAWAY** 🎉🎉",
          giveawayEnded: "🎉🎉 **GIVEAWAY ENDED** 🎉🎉",
          drawing: "Drawing: {timestamp}",
          dropMessage: "Be the first to react with 🎉 !",
          inviteToParticipate: "React with 🎉 to participate!",
          // drawing: "Drawing: {timestamp}",
          // dropMessage: "Be the first to react with 🎉 !",
          // inviteToParticipate: "React with 🎉 to participate!",
          winMessage:
            "Congratulations, {winners}! shans chy ba piaw aka **{this.prize}**!\n{this.messageURL}",
          embedFooter: "{this.winnerCount} winner(s)",
          noWinner: "Giveaway cancelled, no valid participations.",
          hostedBy: "Hosted by: {this.hostedBy}",
          winners: "Winner(s):",
          endedAt: "Ended at",
          // embedFooter: "{this.winnerCount} winner(s)",
          // noWinner: "Giveaway cancelled, no valid participations.",
          // hostedBy: "Hosted by: {this.hostedBy}",
          // winners: "Winner(s):",
          // endedAt: "Ended at",
        },
      })
      .then((s) => {
 77  
commands/Giveaway/+gstart.js
@@ -0,0 +1,77 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "startexect",
  description: `Start Expect Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "channel",
      description: `ping a channel for giveaway`,
      type: "CHANNEL",
      required: true,
    },
    {
      name: "duration",
      description: `give giveaway duration`,
      type: "STRING",
      required: true,
    },
    {
      name: "wincount",
      description: `give winnercount for giveaway`,
      type: "NUMBER",
      required: true,
    },
    {
      name: "prize",
      description: `give prize for giveaway`,
      type: "STRING",
      required: true,
    },
  ],
  // command start
  run: async ({ client, interaction, args }) => {
    // Code
    let channel = interaction.options.getChannel("channel");
    let duration = interaction.options.getString("duration");
    let winCount = interaction.options.getNumber("wincount");
    let prize = interaction.options.getString("prize");

    manager
      .start(channel, {
        prize: prize,
        duration: ms(duration),
        winnerCount: winCount,
        hostedBy: interaction.member,
        messages: {
          giveaway: "🎉🎉 **GIVEAWAY** 🎉🎉",
          giveawayEnded: "🎉🎉 **GIVEAWAY ENDED** 🎉🎉",
          drawing: "Drawing: {timestamp}",
          dropMessage: "Be the first to react with 🎉 !",
          inviteToParticipate: "React with 🎉 to participate!",
          winMessage:
            "Congratulations, {winners}! You won **{this.prize}**!\n{this.messageURL}",
          embedFooter: "{this.winnerCount} winner(s)",
          noWinner: "Giveaway cancelled, no valid participations.",
          hostedBy: "Hosted by: {this.hostedBy}",
          winners: "Winner(s):",
          endedAt: "Ended at",
        },
        exemptMembers: (member) =>
          !member.roles.cache.some((r) => r.name === "Nitro")
      })
      .then((s) => {
        interaction.followUp(`Giveaway Started in ${channel}`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
  43  
handlers/GiveawayClient.js
@@ -1,6 +1,7 @@
const { GiveawaysManager } = require("discord-giveaways");
const { GiveawaysManager, Giveaway } = require("discord-giveaways");
const { MessageEmbed, Interaction } = require("discord.js");
const Enmap = require("enmap");
const client = require('../index')
const client = require("../index");
const giveawayDB = new Enmap({ name: "giveaways" });

const GiveawayManagerWithOwnDatabase = class extends GiveawaysManager {
@@ -27,6 +28,33 @@ const GiveawayManagerWithOwnDatabase = class extends GiveawaysManager {
      this.giveawaysManager.getAllGiveaways()
    );
  }
  /**
   * @param {Giveaway} giveaway
   */
  generateMainEmbed(giveaway) {
    let mainEmbed = new MessageEmbed()
      .setColor("RANDOM")
      .setTitle(`Giveaway Started`)
      .setDescription(
        `>>> ** [React to Enter in Giveaway](${giveaway.messageURL}) **`
      )
      .addFields([
        {
          name: `**🎁 Prize **`,
          value: `>>> ${giveaway.prize}`,
        },
        {
          name: `**⏲️  Duration **`,
          value: `>>> ${giveaway.duration.toLocaleString()}`,
        },
        {
          name: `**👍 Hosted By **`,
          value: `>>> ${giveaway.hostedBy}`,
        },
      ]);

    return mainEmbed;
  }
};

const manager = new GiveawayManagerWithOwnDatabase(client, {
@@ -40,7 +68,12 @@ const manager = new GiveawayManagerWithOwnDatabase(client, {

module.exports = manager;

manager.on("giveawayReactionAdded", async (giveaway, member) => {
  member.send(
    `Your Entry Successfully Accepted \n Giveaway in <#${giveaway.channelId}>`
  );
});

manager.on('giveawayReactionAdded',async (giveaway , member) => {
  member.send(`Your Entry Successfully Accepted \n Giveaway in <#${giveaway.channelId}>`)
})
manager.on("giveawayReactionRemoved", async (giveaway, member, reaction) => {
  member.send(`Your Entry is Rejected...`);
});
  8  
handlers/slash_handler.js
@@ -35,11 +35,9 @@ module.exports = (client) => {
      }
      try {
        client.on("ready", async () => {
          await client.application.commands
            .set(client.arrayOfcommands)
            .catch((e) => {
              console.log(e.message);
            });
          client.guilds.cache
            .get("903532162236694539")
            .commands.set(client.arrayOfcommands);
        });
      } catch (e) {
        console.log(e.message);
 2  
settings/config.json
@@ -1,5 +1,5 @@
{
    "token": "BOT_TOKEN",
    "token": "MTAxNjE0NDIwMDU0MDEwNjg3Mw.G5AwWX.sBxwE2Ai2-mht3TBsigK-x94zJrXPd_AcVPIrw",
    "ownerid": [
        "OWNER_ID"936732561508565045"
        "OWNER_ID"554357469015703572"
