import { BooleanLike } from 'common/react';
import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  NumberInput,
  Section,
  Stack,
} from '../components';
import { Window } from '../layouts';

type AIEquipmentPreset = {
  name: string;
  path: string;
  description: string;
};

type BackendContext = {
  presets: { [key: string]: AIEquipmentPreset[] };
  zombieDelimbMulti: number;
  randomHelmet: BooleanLike;
  autoClean: BooleanLike;
  helmetChance: number;
};

export const HumanAISpawner = (props) => {
  const { data, act } = useBackend<BackendContext>();
  const [chosenPreset, setPreset] = useState<AIEquipmentPreset | null>(null);
  const [newZombieDelimbMulti, setZombieDelimbMulti] = useState<number | null>(
    data.zombieDelimbMulti,
  );
  const [randomHelmetChecked, setRandomHelmetChecked] = useState<BooleanLike>(
    data.randomHelmet,
  );
  const [newHelmetChance, setNewHelmetChance] = useState<number>(
    data.helmetChance,
  );
  const { presets } = data;
  const [aiAmount, setAiAmount] = useState<number>(1);
  const [disableAutoClean, setDisableAutoClean] = useState<BooleanLike>(
    data.autoClean,
  );

  const flipRandomHelmetChecked = () => {
    if (randomHelmetChecked) {
      setRandomHelmetChecked(false);
    } else {
      setRandomHelmetChecked(true);
    }
  };
  const flipDisableAutoClean = () => {
    if (disableAutoClean) {
      setDisableAutoClean(false);
    } else {
      setDisableAutoClean(true);
    }
  };
  const processNumber = (value) => {
    if (value <= 0) {
      setZombieDelimbMulti(-1);
    } else {
      setZombieDelimbMulti(value.toFixed(2));
    }
  };
  return (
    <Window title="Human AI Spawner" width={800} height={900}>
      <Window.Content>
        <Stack fill vertical>
          <Stack fill>
            <Stack.Item grow mr={1}>
              <Section fill scrollable>
                {Object.keys(presets).map((dictKey) => (
                  <Collapsible title={dictKey} key={dictKey} color="good">
                    {presets[dictKey].map((squad) => (
                      <Box pb={'12px'} key={squad.path}>
                        <Button
                          fontSize="15px"
                          textAlign="center"
                          selected={squad === chosenPreset}
                          width="100%"
                          key={squad.path}
                          onClick={() => setPreset(squad)}
                        >
                          {squad.name}
                        </Button>
                      </Box>
                    ))}
                  </Collapsible>
                ))}
              </Section>
            </Stack.Item>
            <Divider vertical />
            <Stack.Item width="30%">
              <Section title="Selected Preset">
                {chosenPreset !== null ? (
                  <Stack vertical>
                    <Stack.Item>{chosenPreset.description}</Stack.Item>
                    <Stack.Item>
                      <Button
                        textAlign="center"
                        width="100%"
                        onClick={() =>
                          act('create_ai', {
                            path: chosenPreset.path,
                            zombieDelimbMulti: newZombieDelimbMulti,
                            randomHelmet: randomHelmetChecked,
                            helmetChance: newHelmetChance,
                            aiAmount: aiAmount,
                            disableAutoClean: disableAutoClean,
                          })
                        }
                      >
                        Spawn
                      </Button>
                    </Stack.Item>
                    <Stack.Item width="100%" align="center" textAlign="center">
                      <Box>Number to spawn:</Box>
                      <Button tooltip="The number of a selected preset to spawn, from 1 to 10. It will only spawn on open tiles, and attempt not to reuse already spawned on tiles during this instance of spawning.">
                        ?
                      </Button>
                      <NumberInput
                        value={aiAmount}
                        step={1}
                        minValue={1}
                        maxValue={10}
                        onChange={(value) => setAiAmount(value)}
                        width="55%"
                      />
                      <Button icon="undo" onClick={() => setAiAmount(1)} />
                    </Stack.Item>
                    {chosenPreset.path.match('zombie') !== null ? (
                      <Stack.Item>
                        <Stack.Item align="center" textAlign="center">
                          <Box>Zombie Delimbing Multiplier:</Box>
                          <Button tooltip="This value will change a delimb modifier that is applied to the spawned zombie. 1 is default. -1 turns delimbing off. 0.5 would half the chance. 2 would double it. Understand that you're affecting the probability as a percentage chance. Values beyond 0.5 and 1.5 aren't recommended.">
                            ?
                          </Button>
                          <NumberInput
                            value={
                              newZombieDelimbMulti ? newZombieDelimbMulti : 1
                            }
                            step={0.01}
                            minValue={-1}
                            maxValue={20}
                            onChange={(value) => processNumber(value)}
                            width="55%"
                          />
                          <Button
                            icon="undo"
                            onClick={() => setZombieDelimbMulti(1)}
                          />
                        </Stack.Item>
                        <Stack.Item align="center" textAlign="center">
                          <Button.Checkbox
                            checked={randomHelmetChecked}
                            onClick={() => flipRandomHelmetChecked()}
                          >
                            Random <i>Zombie Helmet</i> Chance?
                          </Button.Checkbox>
                        </Stack.Item>
                        <Stack.Item align="center" textAlign="center">
                          <Button tooltip="This value will change the chance for a zombie to spawn with head protection in 0-100%. Helmets give one expendable decap protection, and these will have hands and feet protection baked in, rest of the body should be covered by armoured presets.">
                            ?
                          </Button>
                          <NumberInput
                            value={newHelmetChance}
                            step={1}
                            minValue={0}
                            maxValue={100}
                            onChange={(value) => setNewHelmetChance(value)}
                            width="55%"
                          />
                          <Button
                            icon="undo"
                            onClick={() => setNewHelmetChance(25)}
                          />
                        </Stack.Item>
                        <Stack.Item align="center" textAlign="center">
                          <Button.Checkbox
                            checked={disableAutoClean}
                            onClick={() => flipDisableAutoClean()}
                          >
                            Disable Auto-Clean?
                          </Button.Checkbox>
                        </Stack.Item>
                        <Stack.Item align="center" textAlign="center">
                          <Button tooltip="It is recommended to only use this setting for a LIMITED number of zombies. And it does not turn itself off, so please do so manually when you next need to spawn zombie. This setting, if enabled will set the variable [zombie_disable_auto_clean] to true, stopping and limbs and the body from decaying. Use it sparingly and definitely not for any defense styled operations where zombie bodies will pile up. Variable can be var-edited to affect the body but not any lost limbs, from about 50-130 seconds after the zombie checks itself as 'Perma'.">
                            ?
                          </Button>
                          <Button
                            textAlign="center"
                            width="55%"
                            onClick={() => flipDisableAutoClean()}
                          >
                            Toggle Auto-Clean
                          </Button>
                          <Button
                            icon="undo"
                            onClick={() => setDisableAutoClean(false)}
                          />
                        </Stack.Item>
                      </Stack.Item>
                    ) : (
                      <div />
                    )}
                  </Stack>
                ) : (
                  <div />
                )}
              </Section>
            </Stack.Item>
          </Stack>
        </Stack>
      </Window.Content>
    </Window>
  );
};
