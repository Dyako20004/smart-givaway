MIT License

Copyright (c) 2022 ᴋᴀʙɪʀ々ꜱɪɴɢʜ

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
MIT License
Copyright (c) 2021 ᴋᴀʙɪʀ々ꜱɪɴɢʜ
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 29  
README.md
@@ -1,2 +1,27 @@
# discord-giveaway-bot-v13
A Latest V13 Advance Discord Bot With Slash Commands and Custom Enmap Database
<h1 align="center">
Best Class Based Discord.js Handler </h1><br/>

## **Installation | How to use the Bot**

**1.** Install [node.js v16](https://nodejs.org/en/) or higher

**2.** Download this repo and unzip it | or git clone it

**3.** Fill in everything in **`config.json`**

**4.** after Fill everything in config run **`setup.bat`**

**5.** start the bot with **`start.bat`**
<br/>

### _Modify - config.json_

```javascript
{
    "token": "Bot_Token",
}
```

<br/>

If Any Bug Open Pull Request
 15  
command_exapmle.js
@@ -0,0 +1,15 @@
const { Command } = require("reconlx");
const ee = require('../../settings/embed.json')
const config = require('../../settings/config.json')

module.exports = new Command({
    // options
    name: '',
    description: ``,
    userPermissions: [],
    category : "",
    // command start
    run: async ({ client, interaction, args }) => {
        // Code
    }
})
 32  
commands/Giveaway/delete.js
@@ -0,0 +1,32 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "delete",
  description: `delete Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give me giveaway ID`,
      type: "STRING",
      required: true,
    },
  ],
  // command delete
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");
    manager.delete(ID,true)
    .then(s => {
        interaction.followUp(`Giveaway Successfully Deleted`)
    }).catch(e => {
        console.log(e)
    })
  },
});
 60  
commands/Giveaway/edit.js
@@ -0,0 +1,60 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "edit",
  description: `edit Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give giveaway ID`,
      type: "STRING",
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
  // command edit
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");
    let duration = interaction.options.getString("duration");
    let winCount = interaction.options.getNumber("wincount");
    let prize = interaction.options.getString("prize");

    manager
      .edit(ID, {
        addTime: duration,
        newPrize: prize,
        newWinnerCount: winCount,
      })
      .then((s) => {
        interaction.followUp(`Giveaway Successfully Edited`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
 32  
commands/Giveaway/end.js
@@ -0,0 +1,32 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "end",
  description: `end Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give me giveaway ID`,
      type: "STRING",
      required: true,
    },
  ],
  // command end
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");

    manager.end(ID).then(s => {
        interaction.followUp(`Giveaway Ended Winner is Selected`)
    }).catch(e => {
        console.log(e)
    })
  },
});
 33  
commands/Giveaway/list.js
@@ -0,0 +1,33 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");
const { MessageEmbed } = require("discord.js");

module.exports = new Command({
  // options
  name: "list",
  description: `Get list of current guild giveaways`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  // command resume
  run: async ({ client, interaction, args }) => {
    // Code
    let giveaways = await manager.giveaways
      .filter((g) => g.guildId === interaction.guildId)
      .map((g, i) => {
        return `\`${i + 1}\` [Giveaway ${i + 1}](${g.messageURL}) ${
          g.hostedBy
        }`;
      });

      interaction.followUp({embeds : [
          new MessageEmbed()
          .setColor('RANDOM')
          .setTitle(`** All Giveaways of ${interaction.guild.name} **`)
          .setDescription(giveaways.join('\n\n').substr(0,3000))
          .setFooter({text : `Coded By Kabir Singh`,iconURL : interaction.guild.iconURL({dynamic : true})})
      ]})
  },
});
 37  
commands/Giveaway/pause.js
@@ -0,0 +1,37 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "pause",
  description: `pause Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give me giveaway ID`,
      type: "STRING",
      required: true,
    },
  ],
  // command pause
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");

    manager
      .pause(ID, {
        isPaused: true,
      })
      .then((s) => {
        interaction.followUp(`Giveaway Paused Successfully...`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
 40  
commands/Giveaway/reroll.js
@@ -0,0 +1,40 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "reroll",
  description: `reroll Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give me giveaway ID`,
      type: "STRING",
      required: true,
    },
  ],
  // command reroll
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");
    manager
      .reroll(ID, {
        messages: {
          congrat:
            ":tada: New winner(s): {winners}! Congratulations, you won **{this.prize}**!\n{this.messageURL}",
          error: "No valid participations, no new winner(s) can be chosen!",
        },
      })
      .then((s) => {
        interaction.followUp(`Giveaway Successfully Rerolled`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
 34  
commands/Giveaway/resume.js
@@ -0,0 +1,34 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "resume",
  description: `resume Giveaway in your server`,
  userPermissions: ["MANAGE_MESSAGES"],
  category: "Giveaway",
  options: [
    {
      name: "id",
      description: `give me giveaway ID`,
      type: "STRING",
      required: true,
    },
  ],
  // command resume
  run: async ({ client, interaction, args }) => {
    // Code
    let ID = interaction.options.getString("id");
    manager
      .unpause(ID)
      .then((s) => {
        interaction.followUp(`Giveaway Resumed Successfully`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
 75  
commands/Giveaway/start.js
@@ -0,0 +1,75 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const manager = require("../../handlers/GiveawayClient");
const ms = require("ms");

module.exports = new Command({
  // options
  name: "start",
  description: `Start Giveaway in your server`,
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
      })
      .then((s) => {
        interaction.followUp(`Giveaway Started in ${channel}`);
      })
      .catch((e) => {
        console.log(e);
      });
  },
});
 53  
commands/Information/help.js
@@ -0,0 +1,53 @@
const { Command } = require("reconlx");
const ee = require("../../settings/embed.json");
const config = require("../../settings/config.json");
const { MessageEmbed, MessageActionRow, MessageButton } = require("discord.js");

module.exports = new Command({
  // options
  name: "help",
  description: `See my Commands...`,
  userPermissions: ["SEND_MESSAGES"],
  category: "Information",
  // command start
  run: async ({ client, interaction, args }) => {
    // Code
    let btnraw = new MessageActionRow().addComponents([
      new MessageButton()
        .setStyle("LINK")
        .setLabel("Invite Now")
        .setURL(
          `https://discord.com/api/oauth2/authorize?client_id=${client.user.id}&permissions=8&scope=bot%20applications.commands`
        ),
    ]);
    let homeEmbed = new MessageEmbed()
      .setColor(ee.embed_color)
      .setFooter({ text: ee.embed_footertext, iconURL: ee.embed_footericon })
      .setThumbnail(client.user.displayAvatarURL({ dynamic: true }))
      .setDescription(`>>> Total ${client.commands.size} Commands`)
      .setTitle(`Information About ${client.user.username}`);

    const commands = (category) => {
      return client.commands
        .filter((cmd) => cmd.category === category)
        .map((cmd) => `\`${cmd.name}\``);
    };

    try {
      for (let i = 0; i < client.categories.length; i++) {
        const current = client.categories[i];
        const items = commands(current);
        homeEmbed.addField(
          `** ${current.toUpperCase()} \`[${items.length}]\` **`,
          `>>> ${items.join(" ' ")}`
        );
      }
    } catch (e) {
      console.log(e);
    }

    interaction
      .followUp({ embeds: [homeEmbed], components: [btnraw] })
      .catch((e) => console.log(e));
  },
});
 21  
commands/Information/invite.js
@@ -0,0 +1,21 @@
const { Command } = require("reconlx");
const { MessageEmbed } = require("discord.js");
const ee = require('../../settings/embed.json')
const config = require('../../settings/config.json')

module.exports = new Command({
    // options
    name: 'invite',
    description: `Get Bot Invite Link`,
    userPermissions: ['SEND_MESSAGES'],
    category: "Information",
    // command start
    run: async ({ client, interaction, args }) => {
        let embed = new MessageEmbed()
            .setColor(ee.embed_color)
            .setTitle(`Thanks For Inviting Me.`)
            .setDescription(`>>> [Click to Invite](https://discord.com/api/oauth2/authorize?client_id=${client.user.id}&permissions=8&scope=bot)`)
            .setFooter(ee.embed_footertext, ee.embed_footericon)
        interaction.followUp({ embeds: [embed], ephemeral: true })
    }
})
 24  
commands/Information/ping.js
@@ -0,0 +1,24 @@
const { Command } = require("reconlx");
const { MessageEmbed } = require("discord.js");
const ee = require('../../settings/embed.json')
const config = require('../../settings/config.json')

module.exports = new Command({
    // options
    name: 'ping',
    description: `Show Bot Ping`,
    userPermissions: ['SEND_MESSAGES'],
    category : "Information",
    // command start
    run: async ({ client, interaction, args }) => {
        interaction.followUp({
            embeds: [
                new MessageEmbed()
                    .setColor(ee.embed_color)
                    .setTitle(`Ping :- ${client.ws.ping}`)
                    .setFooter(ee.embed_footertext, ee.embed_footericon)
            ],
            ephemeral: true
        })
    }
})
 23  
events/guildCreate.js
@@ -0,0 +1,23 @@
const client = require("../index");
const { MessageEmbed } = require("discord.js");

client.on("guildCreate", async (guild) => {
  if (!guild) return;
  let channel = guild.channels.cache.find(
    (ch) =>
      ch.type === "GUILD_TEXT" &&
      ch.permissionsFor(guild.me).has("SEND_MESSAGES")
  );

  if (guild.me.permissions.has("USE_APPLICATION_commands")) {
    try {
      guild.commands.set(client.arrayOfcommands);
    } catch (e) {
      console.log(e.message);
    }
  } else {
    channel.send(
      `I don't have \`USE_APPLICATION_commands\` so i can't create slash commands in your server , if you want to use me then give me \`USE_APPLICATION_commands\` and reinvite`
    );
  }
});
 54  
events/interactionCreate.js
@@ -0,0 +1,54 @@
const { MessageEmbed } = require("discord.js");
const client = require("..");
var config = require("../settings/config.json");
var ee = require("../settings/embed.json");

client.on("interactionCreate", async (interaction) => {
  // Slash Command Handling
  if (interaction.isCommand()) {
    await interaction.deferReply({ ephemeral : false }).catch(() => {});

    const cmd = client.commands.get(interaction.commandName);
    if (!cmd) return interaction.followUp({ content: "An error has occured " });

    const args = [];

    for (let option of interaction.options.data) {
      if (option.type === "SUB_COMMAND") {
        if (option.name) args.push(option.name);
        option.options?.forEach((x) => {
          if (x.value) args.push(x.value);
        });
      } else if (option.value) args.push(option.value);
    }
    interaction.member = interaction.guild.members.cache.get(
      interaction.user.id
    );
    if (interaction.member.id === client.user.id) {
      interaction.followUp(`Its Me...`);
    }
    if (cmd) {
      // checking user perms
      if (!interaction.member.permissions.has(cmd.userPermissions || [])) {
        return interaction.followUp({
          embeds: [
            new MessageEmbed()
              .setColor(ee.embed_color)
              .setDescription(
                `You don't Have ${cmd.userPermissions} To Run Command..`
              )
              .setFooter(ee.embed_footertext, ee.embed_footericon),
          ],
        });
      }
      cmd.run({ client, interaction, args });
    }
  }

  // Context Menu Handling
  if (interaction.isContextMenu()) {
    await interaction.deferReply({ ephemeral: false });
    const command = client.commands.get(interaction.commandName);
    if (command) command.run(client, interaction);
  }
});
 18  
events/messageCreate.js
@@ -0,0 +1,18 @@
const { MessageEmbed } = require("discord.js");
const client = require("..");
const ee = require('../settings/embed.json')
client.on('messageCreate', async (message) => {
    if (message.author.bot || !message.guild) return

    const prefixRegex = new RegExp(`^(<@!?${client.user.id}>)`);
    if (!prefixRegex.test(message.content)) return;
    const [, mPrefix] = message.content.match(prefixRegex);
    if (mPrefix.includes(client.user.id)) {
        message.reply({
            embeds: [new MessageEmbed()
                .setColor(ee.embed_color)
                .setFooter(ee.embed_footertext, ee.embed_footericon)
                .setTitle(`**To See My All Commans Type **\`/help\``)]
        })
    }
})
 9  
events/ready.js
@@ -0,0 +1,9 @@
const client = require("..");

client.on('ready', () => {
    console.log(`${client.user.username} Is Online`);
    client.user.setActivity({
        name : `Giveaways`,
        type :"WATCHING",
    })
})
 9  
events/threadCreate.js
@@ -0,0 +1,9 @@
const client = require("..");

client.on('threadCreate', (thread) => {
    try {
        thread.join()
    } catch (e) {
        console.log(e.message);
    }
})
 46  
handlers/GiveawayClient.js
@@ -0,0 +1,46 @@
const { GiveawaysManager } = require("discord-giveaways");
const Enmap = require("enmap");
const client = require('../index')
const giveawayDB = new Enmap({ name: "giveaways" });

const GiveawayManagerWithOwnDatabase = class extends GiveawaysManager {
  async getAllGiveaways() {
    return giveawayDB.fetchEverything().array();
  }
  async saveGiveaway(messageId, giveawayData) {
    giveawayDB.set(messageId, giveawayData);
    return true;
  }

  async editGiveaway(messageId, giveawayData) {
    giveawayDB.set(messageId, giveawayData);
    return true;
  }

  async deleteGiveaway(messageId) {
    giveawayDB.delete(messageId);
    return true;
  }

  async refreshStorage() {
    return client.shard.broadcastEval(() =>
      this.giveawaysManager.getAllGiveaways()
    );
  }
};

const manager = new GiveawayManagerWithOwnDatabase(client, {
  default: {
    botsCanWin: false,
    embedColor: "#FF0000",
    embedColorEnd: "#000000",
    reaction: "🎉",
  },
});

module.exports = manager;


manager.on('giveawayReactionAdded',async (giveaway , member) => {
  member.send(`Your Entry Successfully Accepted \n Giveaway in <#${giveaway.channelId}>`)
})
 26  
handlers/event_handler.js
@@ -0,0 +1,26 @@
const { Client } = require('discord.js');
const fs = require('fs');

/**
   *
   * @param {Client} client
   */

module.exports = (client) => {
    try {
        fs.readdirSync("./events/").forEach((file) => {
            const events = fs.readdirSync("./events/").filter((file) =>
              file.endsWith(".js")
            );
            for (let file of events) {
              let pull = require(`../events/${file}`);
              if (pull.name) {
                client.events.set(pull.name, pull);
              }
            }
            console.log((`${file}  Events Loaded Successfullly`));
          });
    } catch (e) {
        console.log(e.message);
    }
}
 54  
handlers/slash_handler.js
@@ -0,0 +1,54 @@
const { Client, ApplicationCommand } = require("discord.js");
const fs = require("fs");

/**
 *
 * @param {Client} client
 */

module.exports = (client) => {
  try {
    client.arrayOfcommands = [];
    let commandcount = 0;
    fs.readdirSync("./commands").forEach((cmd) => {
      let commands = fs
        .readdirSync(`./commands/${cmd}/`)
        .filter((file) => file.endsWith(".js"));
      for (cmds of commands) {
        let pull = require(`../commands/${cmd}/${cmds}`);
        if (pull.options) {
          pull.options
            .filter((g) => g.type === "SUB_COMMAND")
            .forEach((sub) => {
              client.subcmd.set(sub.name, sub);
            });
        }
        if (pull.name) {
          client.commands.set(pull.name, pull);
          commandcount++;
          client.arrayOfcommands.push(pull);
        } else {
          continue;
        }
        if (pull.aliases && Array.isArray(pull.aliases))
          pull.aliases.forEach((alias) => client.aliases.set(alias, pull.name));
      }
      try {
        client.on("ready", async () => {
          await client.application.commands
            .set(client.arrayOfcommands)
            .catch((e) => {
              console.log(e.message);
            });
        });
      } catch (e) {
        console.log(e.message);
      }
    });
    console.log(`[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
      Loaded ${commandcount} commands
    ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]`);
  } catch (e) {
    console.log(e);
  }
};
 69  
index.js
@@ -0,0 +1,69 @@
const { Client, Collection, Intents } = require('discord.js');
const fs = require("fs");
const client = new Client({
  messageCacheLifetime: 60,
  fetchAllMembers: false,
  messageCacheMaxSize: 10,
  restTimeOffset: 0,
  restWsBridgetimeout: 100,
  shards: "auto",
  allowedMentions: {
    parse: ["roles", "users", "everyone"],
    repliedUser: true,
  },
  partials: ["MESSAGE", "CHANNEL", "REACTION"],
  intents: [
    Intents.FLAGS.GUILDS,
    Intents.FLAGS.GUILD_MEMBERS,
    // Intents.FLAGS.GUILD_BANS,
    // Intents.FLAGS.GUILD_EMOJIS_AND_STICKERS,
    //Intents.FLAGS.GUILD_INTEGRATIONS,
    //Intents.FLAGS.GUILD_WEBHOOKS,
    //Intents.FLAGS.GUILD_INVITES,
    // Intents.FLAGS.GUILD_VOICE_STATES,
    //Intents.FLAGS.GUILD_PRESENCES,
    Intents.FLAGS.GUILD_MESSAGES,
    Intents.FLAGS.GUILD_MESSAGE_REACTIONS,
    //Intents.FLAGS.GUILD_MESSAGE_TYPING,
    // Intents.FLAGS.DIRECT_MESSAGES,
    // Intents.FLAGS.DIRECT_MESSAGE_REACTIONS,
    //Intents.FLAGS.DIRECT_MESSAGE_TYPING
  ],
});
module.exports = client;

const config = require("./settings/config.json");
const ee = require("./settings/embed.json");
const prefix = config.prefix;
const token = config.token;
// Global Variables
client.events = new Collection();
client.cooldowns = new Collection();
client.commands = new Collection();
client.categories = fs.readdirSync("./commands/");

// Initializing the project
//Loading files, with the client variable like Command Handler, Event Handler, ...
["event_handler", "slash_handler"].forEach((handler) => {
    require(`./handlers/${handler}`)(client)
});

client.login(token);


process.on('unhandledRejection', (reason, p) => {
    console.log(' [Error_Handling] :: Unhandled Rejection/Catch');
    console.log(reason, p);
});
process.on("uncaughtException", (err, origin) => {
    console.log(' [Error_Handling] :: Uncaught Exception/Catch');
    console.log(err, origin);
})
process.on('uncaughtExceptionMonitor', (err, origin) => {
    console.log(' [Error_Handling] :: Uncaught Exception/Catch (MONITOR)');
    console.log(err, origin);
});
process.on('multipleResolves', (type, promise, reason) => {
    console.log(' [Error_Handling] :: Multiple Resolves');
    console.log(type, promise, reason);
});
 20  
package.json
@@ -0,0 +1,20 @@
{
  "name": "handler",
  "version": "2.1.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "keywords": [],
  "author": "KabirSingh",
  "license": "ISC",
  "dependencies": {
    "discord-giveaways": "^5.0.1",
    "discord.js": "^13.3.0",
    "enmap": "^5.8.7",
    "mongoose": "^6.0.12",
    "ms": "^2.1.3",
    "reconlx": "^2.5.1"
  }
}
 7  
settings/config.json
@@ -0,0 +1,7 @@
{
    "token": "BOT_TOKEN",
    "ownerid": [936732561508565045[
        "OWNER_ID"936732561508565045
        "OWNER_ID"936732561508565045
    ]
}
 6  
settings/embed.json
@@ -0,0 +1,6 @@
{
    "embed_color": "#3498db",
    "embed_wrongcolor": "#e01e01",
    "embed_footertext": "Coded By Kabir Singh | Tech Boy Development",
    "embed_footericon": "https://img.icons8.com/color/452/discord-logo.png"
}
 1  
setup.bat
@@ -0,0 +1 @@
npm install
 1  
start.bat
@@ -0,0 +1 @@
node .
