import { BooleanLike } from 'common/react';
import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Divider,
  Dropdown,
  Section,
  Slider,
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
  selected_faction: string;
  selectable_factions: string[];
  spawn_ai: boolean;
  paradrop: boolean;
  outfit: number;
  desc: number;
  spawn_click_intercept: boolean;
  equipment_settings: string[];
  selected_equipment: string;
  species_settings: string[];
  species_selected: string;
  zombie_outer_wear: boolean;
  zombie_outer_wear_chance: number;
  zombie_delimb_multi: number;
  clipboard: string;
  autoClean: BooleanLike;
};

export const HumanAISpawner = (props) => {
  const { data, act } = useBackend<BackendContext>();
  const [chosenPreset, setPreset] = useState<AIEquipmentPreset | null>(null);
  const [viewingFaction, setViewingFaction] = useState<string | null>(null);
  const { presets } = data;

  const factionOptions = Object.keys(presets);

  return (
    <Window title="Human AI Spawner" width={800} height={900}>
      <Window.Content>
        <Stack fill vertical>
          <Stack fill>
            {/* left panel*/}
            <Stack.Item grow mr={1}>
              <Box mb={1}>
                <Dropdown
                  placeholder="Filter by Faction..."
                  options={factionOptions}
                  selected={viewingFaction}
                  width="100%"
                  onSelected={(value) => setViewingFaction(value)}
                />
              </Box>
              <Section
                fill
                scrollable
                title="Presets"
                buttons={
                  <Button
                    textAlign="center"
                    width="100%"
                    onClick={() => act('add_preset')}
                  >
                    Add Preset
                  </Button>
                }
              >
                <Divider />
                {viewingFaction ? (
                  <Box mt={1}>
                    {presets[viewingFaction]?.map((squad) => (
                      <Box pb="12px" key={squad.path}>
                        <Button
                          fontSize="15px"
                          textAlign="center"
                          selected={squad.path === chosenPreset?.path}
                          // key={squad?.path}
                          width="100%"
                          onClick={() => {
                            setPreset(squad);
                            act('remember_path', {
                              path: squad.path,
                            });
                          }}
                        >
                          {squad.name}
                        </Button>
                      </Box>
                    ))}
                  </Box>
                ) : (
                  <Box textAlign="center" italic color="label">
                    Select a faction to view presets
                  </Box>
                )}
              </Section>
            </Stack.Item>
            <Divider vertical />
            {/* right panel*/}
            <Stack.Item width="30%">
              <Section
                title="Selected Preset"
                buttons={
                  <span>
                    {chosenPreset !== null ? (
                      /*
                      <span>
                        <Button.Checkbox
                          icon="clipboard"
                          onClick={() => {
                            act('save');
                          }}
                        />
                        */
                      <Button.Checkbox
                        icon="trash"
                        onClick={() =>
                          act('delete_preset', {
                            path: chosenPreset.path,
                          })
                        }
                      />
                    ) : null}
                  </span>
                }
              >
                {chosenPreset !== null ? (
                  <Stack vertical>
                    <Stack.Item>
                      {data.desc === 1 && chosenPreset.description}
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        textAlign="center"
                        width="100%"
                        selected={data.spawn_click_intercept}
                        onClick={() =>
                          act('create_ai', {
                            path: chosenPreset.path,
                            selected_faction: data.selected_faction,
                            selected_equipment: data.selected_equipment,
                          })
                        }
                      >
                        {data.outfit === 1 ? 'Outfit' : 'Click Spawn'}
                      </Button>
                      {/* path: selected_faction: etc get passed as the params["path"]*/}
                    </Stack.Item>
                    <Stack.Item>
                      <Dropdown
                        width="100%"
                        options={data.selectable_factions}
                        selected={data.selected_faction}
                        displayText={
                          <span
                            style={{
                              color: data.selected_faction
                                ?.toLowerCase()
                                .includes('hive')
                                ? 'purple'
                                : data.selected_faction !== chosenPreset.faction
                                  ? 'pink'
                                  : 'white',
                            }}
                          >
                            {data.selected_faction}
                          </span>
                        }
                        onSelected={(selected_faction) => {
                          act('set_selected_faction', {
                            selected_faction: selected_faction,
                            path: chosenPreset.path,
                          });
                        }}
                      />
                    </Stack.Item>

                    <Button.Checkbox
                      checked={data.paradrop}
                      onClick={() => {
                        act('paradrop_toggle');
                      }}
                    >
                      Parachute
                    </Button.Checkbox>
                    <Button.Checkbox
                      checked={data.outfit}
                      onClick={() => {
                        act('outfit');
                      }}
                    >
                      Click gives outfit
                    </Button.Checkbox>
                    <Section title="Additional Options" />
                    {data.species_selected === 'Zombie' ? (
                      <Stack align="baseline">
                        <Stack.Item>
                          <Button.Checkbox
                            checked={data.zombie_outer_wear}
                            onClick={() => {
                              act('zombie_outer_wear');
                            }}
                          >
                            Helmet
                          </Button.Checkbox>
                        </Stack.Item>
                        <Stack.Item grow>
                          <Slider
                            maxValue={100}
                            minValue={0}
                            value={data.zombie_outer_wear_chance}
                            onChange={(e, value) =>
                              act('zombie_outer_wear_chance', {
                                zombie_outer_wear_chance: value,
                              })
                            }
                            unit={'%'}
                            step={10}
                            stepPixelSize={10}
                          />
                        </Stack.Item>
                      </Stack>
                    ) : null}
                    {data.species_selected === 'Zombie' ? (
                      <Stack align="baseline">
                        <Button.Checkbox
                          textAlign="center"
                          width="55%"
                          checked={data.autoClean}
                          onClick={() => act('auto_clean')}
                        >
                          Auto-Clean
                        </Button.Checkbox>
                        <Slider
                          maxValue={2000}
                          minValue={-100}
                          value={data.zombie_delimb_multi * 100}
                          onChange={(e, value) =>
                            act('zombie_delimb_multi', {
                              zombie_delimb_multi: value / 100,
                            })
                          }
                          unit={'% delimb'}
                          step={100}
                          stepPixelSize={10}
                        />
                      </Stack>
                    ) : null}
                    <Dropdown
                      width="100%"
                      options={data.species_settings}
                      selected={data.species_selected}
                      displayText={
                        <span
                          style={{
                            color:
                              data.species_selected
                                ?.toLowerCase()
                                .includes('synth') ||
                              data.selected_faction
                                ?.toLowerCase()
                                .includes('working joe')
                                ? 'blue'
                                : data.species_selected !== 'Human'
                                  ? 'olive'
                                  : 'white',
                          }}
                        >
                          {data.species_selected}
                        </span>
                      }
                      onSelected={(species_selected) => {
                        act('set_selected_species', {
                          species_selected: species_selected,
                        });
                      }}
                    />
                    <Dropdown
                      width="100%"
                      options={data.equipment_settings}
                      selected={data.selected_equipment}
                      displayText={
                        <span
                          style={{
                            color:
                              data.selected_equipment === 'Birthday Suit'
                                ? 'pink'
                                : data.selected_equipment !== 'Full Equipment'
                                  ? 'orange'
                                  : 'white',
                          }}
                        >
                          {data.selected_equipment}
                        </span>
                      }
                      onSelected={(selected_equipment) => {
                        act('set_selected_equipment', {
                          selected_equipment: selected_equipment,
                          path: chosenPreset.path,
                        });
                      }}
                    />
                    <Button.Checkbox
                      checked={data.spawn_ai}
                      onClick={() => {
                        act('human_spawn_ai_toggle');
                      }}
                    >
                      AI
                    </Button.Checkbox>
                  </Stack>
                ) : (
                  <Box textAlign="center" italic color="label">
                    No preset selected
                  </Box>
                )}
              </Section>
              <Section />
            </Stack.Item>
          </Stack>
        </Stack>
      </Window.Content>
    </Window>
  );
};
