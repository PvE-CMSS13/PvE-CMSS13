import { useBackend, useLocalState } from '../backend';
import { Button, Section, Slider, Tabs, Stack } from '../components';
import { Window } from '../layouts';

export const MapManipulation = (props, context) => {
  const { data, act } = useBackend(context);
  const [main_tab, setTab] = useLocalState(context, 'main_tab', data.main_tab);

  return (
    <Window title="Map Manipulator" width={420} height={430}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={main_tab === 1}
            onClick={() => {
              setTab(1);
              act('switch_main_tab', { new_main_tab: 1 });
            }}
            color={'red'}
            icon="bomb">
            Destruction
          </Tabs.Tab>
          {!!data.map_specific_options && (
            <Tabs.Tab
              selected={main_tab === 2}
              onClick={() => {
                setTab(2);
                act('switch_main_tab', { new_main_tab: 2 });
              }}
              color={'blue'}
              icon="screwdriver-wrench">
              Map-Specific
            </Tabs.Tab>
          )}
          {!!data.nightmare_options && (
            <Tabs.Tab
              selected={main_tab === 3}
              onClick={() => {
                setTab(3);
                act('switch_main_tab', { new_main_tab: 3 });
              }}
              color={'purple'}
              icon="map">
              Nightmare Gen
            </Tabs.Tab>
          )}
        </Tabs>
        {main_tab === 1 && <DestructionTab />}
        {main_tab === 2 && <MapSpecificTab />}
        {main_tab === 3 && <NightmareTab />}
      </Window.Content>
    </Window>
  );
};

export const DestructionTab = (props, context) => {
  const [dest_tab, setTab] = useLocalState(context, 'dest_tab', 1);

  return (
    <Stack vertical>
      <ParametersPanel />
      <PresetsPanel />
      <Tabs>
        <Tabs.Tab
          selected={dest_tab === 1}
          onClick={() => setTab(1)}
          icon="plug">
          Machines
        </Tabs.Tab>
        <Tabs.Tab
          selected={dest_tab === 2}
          onClick={() => setTab(2)}
          icon="tower-observation">
          Structures
        </Tabs.Tab>
        <Tabs.Tab
          selected={dest_tab === 3}
          onClick={() => setTab(3)}
          icon="building">
          Turfs
        </Tabs.Tab>
        <Tabs.Tab
          selected={dest_tab === 4}
          onClick={() => setTab(4)}
          icon="hand-holding">
          Items
        </Tabs.Tab>
      </Tabs>
      {dest_tab === 1 && <DestroyMachinesTab />}
      {dest_tab === 2 && <DestroyStructuresTab />}
      {dest_tab === 3 && <DestroyTurfsTab />}
      {dest_tab === 4 && <DestroyItemsTab />}
    </Stack>
  );
};

export const ParametersPanel = (props, context) => {
  const { data, act } = useBackend(context);
  const [dest_z, setZValue] = useLocalState(
    context,
    'dest_z',
    data.selected_z_level
  );
  const [dest_r, setRValue] = useLocalState(
    context,
    'dest_r',
    data.percentage_to_break
  );

  return (
    <Section title="Destruction Parameters">
      <Stack>
        <Stack.Item>
          <Button.Input
            tooltip="The Z-Level that will be affected."
            content={dest_z}
            currentValue={dest_z}
            onCommit={(e, z_value) => {
              setZValue(z_value);
              act('selected_z_level', { z_value });
            }}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Slider
            value={dest_r}
            minValue={0}
            maxValue={100}
            ranges={{
              'white': [0],
              'green': [1, 25],
              'yellow': [26, 50],
              'orange': [51, 75],
              'red': [76, 100],
            }}
            step={5}
            stepPixelSize={20}
            onChange={(e, dest_ratio) => {
              setRValue(dest_ratio);
              act('percentage_to_break', { dest_ratio });
            }}
            fluid>
            Destruction Ratio: {dest_r}%
          </Slider>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const PresetsPanel = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Section title="Batch Presets (Ignores Ratio)">
      <Stack textAlign="center">
        <Stack.Item grow>
          <Button
            fluid
            content="Light"
            tooltip="Keep most items intact."
            onClick={() => {
              act('preset_light_damage');
            }}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Button
            fluid
            content="Medium"
            tooltip="Does some turf damage too and light item deletion."
            onClick={() => {
              act('preset_moderate_damage');
            }}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Button
            fluid
            content="Heavy"
            tooltip="More of everything and also more dirt."
            onClick={() => {
              act('preset_heavy_damage');
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const DestroyMachinesTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Section title="Machine Destruction (Fast)">
      <Stack wrap="wrap">
        <Stack.Item>
          <Button
            ml={1}
            color="orange"
            content="ALL Machines (INCONSISTENT | ~50%))"
            tooltip="/obj/structure/machinery"
            onClick={() => {
              act('break_all_machines');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="CM Vendors"
            tooltip="/obj/structure/machinery/cm_vending"
            onClick={() => {
              act('break_gear_vendors');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Normal Vendors"
            tooltip="/obj/structure/machinery/vending"
            onClick={() => {
              act('break_normal_vendors');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Computers and Terminals"
            tooltip="/obj/structure/machinery/computer"
            onClick={() => {
              act('break_computers');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="APCs"
            tooltip="/obj/structure/machinery/power/apc"
            onClick={() => {
              act('break_apcs');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Lights"
            tooltip="/obj/structure/machinery/light"
            onClick={() => {
              act('break_lights');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Cameras"
            tooltip="/obj/structure/machinery/camera"
            onClick={() => {
              act('break_cameras');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Comm Towers"
            tooltip="/obj/structure/machinery/telecomms/relay/preset/tower"
            onClick={() => {
              act('break_comms_towers');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Airlocks (Break or Seal)"
            tooltip="/obj/obj/structure/machinery/door/airlock"
            onClick={() => {
              act('break_airlocks');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Window Doors"
            tooltip="/obj/structure/machinery/door/window"
            onClick={() => {
              act('break_window_doors');
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const DestroyStructuresTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Section title="Structure Destruction (Slower)">
      <Stack wrap="wrap">
        <Stack.Item>
          <Button
            ml={1}
            color="red"
            content="ALL Structures (INCONSISTENT | ~50% | DANGEROUS)"
            tooltip="/obj/structure"
            onClick={() => {
              act('break_all_structures');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Gun Racks"
            tooltip="/obj/structure/gun_rack"
            onClick={() => {
              act('break_gun_racks');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Mirrors"
            tooltip="/obj/structure/mirror"
            onClick={() => {
              act('break_mirrors');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Grilles"
            tooltip="/obj/structure/grille"
            onClick={() => {
              act('break_grilles');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Fences"
            tooltip="/obj/structure/fence"
            onClick={() => {
              act('break_fences');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Barricades"
            tooltip="/obj/structure/barricade"
            onClick={() => {
              act('damage_barricades');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Windows"
            tooltip="/obj/structure/window"
            onClick={() => {
              act('break_windows');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Window Frames"
            tooltip="/obj/structure/window_frame"
            onClick={() => {
              act('break_window_frames');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Chairs | Beds"
            tooltip="/obj/structure/bed"
            onClick={() => {
              act('break_chairs_and_beds');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Tables (Destroy or Flip)"
            tooltip="/obj/structure/surface/table"
            onClick={() => {
              act('break_tables');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Lockers"
            tooltip="/obj/structure/closet"
            onClick={() => {
              act('break_lockers');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Large Crates"
            tooltip="/obj/structure/closet"
            onClick={() => {
              act('break_large_crates');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Racks"
            tooltip="/obj/structure/surface/rack"
            onClick={() => {
              act('break_racks');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Reagent Tanks"
            tooltip="/obj/structure/reagent_dispensers"
            onClick={() => {
              act('break_reagent_tanks');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Powerloaders"
            tooltip="/obj/vehicle/powerloader"
            onClick={() => {
              act('break_powerloaders');
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const DestroyTurfsTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Section title="Turf Destruction (Slowest)">
      <Stack wrap="wrap">
        <Stack.Item>
          <Button
            ml={1}
            content="Walls (With Bullet Holes)"
            tooltip="/turf/wall"
            onClick={() => {
              act('damage_walls', { bullet_holes: 1 });
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Walls (No Bullet Holes)"
            tooltip="/turf/wall"
            onClick={() => {
              act('damage_walls');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Floors"
            tooltip="/turf/open/floor"
            onClick={() => {
              act('damage_floors');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Floors + Pipes/Disposal"
            tooltip="/turf/open/floor"
            onClick={() => {
              act('damage_floors', { break_pipes: 1 });
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Add Dirt Only"
            tooltip="/turf/open/floor"
            onClick={() => {
              act('damage_floors', { add_dirt: 1 });
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const DestroyItemsTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Section title="Item Deletion (Medium)">
      <Stack wrap="wrap">
        <Stack.Item>
          <Button
            ml={1}
            color="yellow"
            content="ALL Items"
            tooltip="/obj/item"
            onClick={() => {
              act('destroy_all_items');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Guns"
            tooltip="/obj/item/weapon/gun"
            onClick={() => {
              act('destroy_guns');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Ammo Mags"
            tooltip="/obj/item/ammo_magazine"
            onClick={() => {
              act('destroy_ammo');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Other Weapons (No Guns)"
            tooltip="/obj/item/weapon"
            onClick={() => {
              act('destroy_weapons');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Devices"
            tooltip="/obj/item/device"
            onClick={() => {
              act('destroy_devices');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Storage Items"
            tooltip="/obj/item/storage"
            onClick={() => {
              act('destroy_item_storage');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Clothing/Equippables"
            tooltip="/obj/item/clothing"
            onClick={() => {
              act('destroy_clothing');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Reagent Containers"
            tooltip="/obj/item/reagent_container"
            onClick={() => {
              act('destroy_reagent_containers');
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            content="Food Only"
            tooltip="/obj/item/reagent_container/food"
            onClick={() => {
              act('destroy_food');
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/*
Tabs without tabs. map_name is fed from the back-end, so it's always a single panel.
Not to be confused with the .map function.
If you're adding maps, just toss them in with their own panels.
Probably much better ways of doing this, but this will suffice for now.
*/

export const MapSpecificTab = (props, context) => {
  const { data, act } = useBackend(context);
  const [sel_map, setCurMap] = useLocalState(
    context,
    'sel_map',
    data.selected_map
  );
  const decl_name = data.map_name;

  return (
    <Stack vertical>
      <Section title="Map Selection">
        <Stack textAlign="center">
          <Stack.Item grow={1}>
            <Button
              fluid
              icon="globe"
              selected={sel_map === 'ground_map'}
              content="Ground Map"
              tooltip="Selects the ground map."
              onClick={() => {
                setCurMap('ground_map');
                act('selected_map', {
                  chosen_map: 'ground_map',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item grow={1}>
            <Button
              fluid
              icon="rocket"
              selected={sel_map === 'ship_map'}
              content="Ship Map"
              tooltip="Selects the ship map."
              onClick={() => {
                setCurMap('ship_map');
                act('selected_map', {
                  chosen_map: 'ship_map',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>
      <Section title={decl_name}>
        {decl_name === 'Blackstone Bridge' && <BlackstonePanel />}
      </Section>
    </Stack>
  );
};

export const BlackstonePanel = (props, context) => {
  const [bstone_tab, setTab] = useLocalState(context, 'bstone_tab', 1);

  return (
    <Stack vertical>
      <Tabs>
        <Tabs.Tab
          selected={bstone_tab === 1}
          onClick={() => setTab(1)}
          icon="square-full">
          Blockers
        </Tabs.Tab>
        <Tabs.Tab
          selected={bstone_tab === 2}
          onClick={() => setTab(2)}
          icon="down-long">
          Hatches
        </Tabs.Tab>
        <Tabs.Tab
          selected={bstone_tab === 3}
          onClick={() => setTab(3)}
          icon="helmet-safety">
          Maintenance
        </Tabs.Tab>
      </Tabs>
      {bstone_tab === 1 && <BlackstoneBlockersTab />}
      {bstone_tab === 2 && <BlackstoneHatchesTab />}
      {bstone_tab === 3 && <BlackstoneMaintenanceTab />}
    </Stack>
  );
};

export const BlackstoneBlockersTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Stack vertical>
      <Section title="Rock Debris">
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              content="Toggle Debris (Mining)"
              tooltip="Near the mining site."
              onClick={() => {
                act('toggle_blocker', {
                  signal_id: 'cave_blocker_1',
                  signal_area:
                    '/area/whiskey_outpost/blackstone/underground/western_caves/north',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle Debris (BBall)"
              tooltip="Near the basketball court."
              onClick={() => {
                act('toggle_blocker', {
                  signal_id: 'cave_blocker_2',
                  signal_area:
                    '/area/whiskey_outpost/blackstone/underground/western_caves/center',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle Debris (Pillbox)"
              tooltip="Near the SW pillbox."
              onClick={() => {
                act('toggle_blocker', {
                  signal_id: 'cave_blocker_3',
                  signal_area:
                    '/area/whiskey_outpost/blackstone/underground/western_caves/south',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle Debris (Jungle)"
              tooltip="Near the SW jungle."
              onClick={() => {
                act('toggle_blocker', {
                  signal_id: 'cave_blocker_4',
                  signal_area:
                    '/area/whiskey_outpost/blackstone/underground/western_caves/south',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>

      <Section title="Tunnel Gates" mt={-2.5}>
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              content="Toggle Tunnel Gates"
              tooltip="Toggles the podlocks that block the mountain tunnel."
              onClick={() => {
                act('toggle_gate', {
                  signal_id: 'tunnel_gate_main',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle LZ Gates"
              tooltip="Toggles the podlocks that block off the landing zone."
              onClick={() => {
                act('toggle_gate', {
                  signal_id: 'tunnel_gate_lz',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>
    </Stack>
  );
};

export const BlackstoneHatchesTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Stack vertical>
      <Section
        title="Maintenance Hatches"
        buttons={
          <Button
            color="transparent"
            content="Toggle ALL Hatches"
            tooltip="Toggles *all* hatch locks; if they were open, closes them."
            onClick={() => {
              act('toggle_hatch', {
                hatch_to_unlock: 'toggle_all',
              });
            }}
          />
        }>
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              content="Toggle LZ Hatch"
              tooltip="Toggles the hatch next to the landing zone."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'landingzone_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle East Hatch"
              tooltip="Toggles the eastern hatch, next to the road."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'east_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle NW Hatch"
              tooltip="Toggles the NW hatch, next to the CIC."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'north_west_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle West Hatch"
              tooltip="Toggles the western hatch, next to CO's office."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'west_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle SE Hatch"
              tooltip="Toggles the SE hatch, above the warehouse storage area."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'south_east_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle SW Hatch"
              tooltip="Toggles the SW hatch, above the warehouse checkpoint vestibule."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'south_west_hatch',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Toggle Bunker Hatch"
              tooltip="Toggles the hidden bunker hatch, which can spawn somewhere in the jungle."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'blackstone_hidden_bunker',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>

      <Section title="Other Hatches" mt={-2.5}>
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              content="Toggle Bunker Hatch"
              tooltip="Toggles the hidden bunker hatch, which can spawn somewhere in the jungle."
              onClick={() => {
                act('toggle_hatch', {
                  hatch_to_unlock: 'blackstone_hidden_bunker',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>
    </Stack>
  );
};

export const BlackstoneMaintenanceTab = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Stack vertical>
      <Section title="Ambushes">
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              color="yellow"
              content="Spawn Ambush Sites"
              tooltip="Randomly spawn a bunch of ambush sites in the maintenance tunnels."
              onClick={() => {
                act('spawn_ambush');
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>

      <Section
        title="Lights"
        mt={-2.5}
        buttons={
          <Button
            color="transparent"
            content="Flicker ALL Lights"
            tooltip="Flickers most lightbulbs in all maintenance areas for a short, random interval."
            onClick={() => {
              act('flicker_light', {
                area_to_flicker: 'all_blackstone_areas',
              });
            }}
          />
        }>
        <Stack wrap="wrap">
          <Stack.Item>
            <Button
              ml={1}
              content="Flicker Lights NE"
              tooltip="Flickers some lightbulbs in that maintenance area for a short, random interval."
              onClick={() => {
                act('flicker_light', {
                  area_to_flicker:
                    '/area/whiskey_outpost/blackstone/underground/maintenance/north_east',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Flicker Lights SE"
              tooltip="Flickers some lightbulbs in that maintenance area for a short, random interval."
              onClick={() => {
                act('flicker_light', {
                  area_to_flicker:
                    '/area/whiskey_outpost/blackstone/underground/maintenance/south_east',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Flicker Lights NW"
              tooltip="Flickers some lightbulbs in that maintenance area for a short, random interval."
              onClick={() => {
                act('flicker_light', {
                  area_to_flicker:
                    '/area/whiskey_outpost/blackstone/underground/maintenance/north_west',
                });
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              content="Flicker Lights SW"
              tooltip="Flickers some lightbulbs in that maintenance area for a short, random interval."
              onClick={() => {
                act('flicker_light', {
                  area_to_flicker:
                    '/area/whiskey_outpost/blackstone/underground/maintenance/south_west',
                });
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>
    </Stack>
  );
};

/*
Cannot use local state to track the values here as someone else can modify them
at any time; as such, this menu will lag a little more than the others, but
that should be okay. Suppose it is possible to use local state, but that would
mean changes made by other people would be hidden from view. Perhaps something
to rework later.
*/

import { map } from 'common/collections';

export const NightmareTab = (props, context) => {
  const { data, act } = useBackend(context);
  const [sel_nigh_map, setNightMap] = useLocalState(
    context,
    'sel_nigh_map',
    'ground_map'
  );

  return (
    <Stack vertical>
      <Section
        title="Map Selection"
        buttons={
          <Button
            color="purple"
            content="Prepare Game"
            tooltip="Fires the Nightmare system early, setting up all of the components before round start."
            onClick={() => {
              act('nightmare_prepare_game');
            }}
          />
        }>
        <Stack textAlign="center">
          <Stack.Item grow={1}>
            <Button
              fluid
              icon="globe"
              selected={sel_nigh_map === 'ground_map'}
              content="Ground Map"
              tooltip="Looks up ground nightmare values."
              onClick={() => {
                setNightMap('ground_map');
              }}
            />
          </Stack.Item>
          <Stack.Item grow={1}>
            <Button
              fluid
              icon="rocket"
              selected={sel_nigh_map === 'ship_map'}
              content="Ship Map"
              tooltip="Looks up ship nightmare values."
              onClick={() => {
                setNightMap('ship_map');
              }}
            />
          </Stack.Item>
        </Stack>
      </Section>
      {sel_nigh_map === 'ground_map' ? (
        <NightmareGroundPanel />
      ) : (
        <NightmareShipPanel />
      )}
    </Stack>
  );
};

// These two menus can be one menu, but some other time.

export const NightmareGroundPanel = (props, context) => {
  const { data, act } = useBackend(context);
  const NightmareGround = data.nightmare_ground || {};
  const NightmareGroundScenario = data.nightmare_ground_scenario || [];
  let ground_i = 0;

  return (
    <Stack vertical>
      {map((value_list, scenario_name) => (
        <Section title={scenario_name} mt={ground_i++ === 0 ? 0 : -2.5}>
          <Stack wrap="wrap">
            {value_list.map((scenario_value, i) => (
              <Stack.Item key={i}>
                <Button
                  ml={i === 0 ? 1 : 0}
                  content={scenario_value}
                  selected={
                    NightmareGroundScenario[scenario_name] === scenario_value
                  }
                  tooltip="Updates the scenario value with this value."
                  onClick={() => {
                    act('nightmare_update_scenario', {
                      nightmare_name: scenario_name,
                      nightmare_value: scenario_value,
                      nightmare_context: 'ground',
                    });
                  }}
                />
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      ))(NightmareGround)}
    </Stack>
  );
};

export const NightmareShipPanel = (props, context) => {
  const { data, act } = useBackend(context);
  const NightmareShip = data.nightmare_ship || {};
  const NightmareShipScenario = data.nightmare_ship || [];
  let ship_i = 0;

  return (
    <Stack vertical>
      {map((value_list, scenario_name) => (
        <Section title={scenario_name} mt={ship_i === 0 ? 0 : -2.5}>
          <Stack wrap="wrap">
            {value_list.map((scenario_value, i) => (
              <Stack.Item key={i}>
                <Button
                  ml={i === 0 ? 1 : 0}
                  content={scenario_value}
                  selected={
                    NightmareShipScenario[scenario_name] === scenario_value
                  }
                  tooltip="Updates the scenario value with this value."
                  onClick={() => {
                    act('nightmare_update_scenario', {
                      nightmare_name: scenario_name,
                      nightmare_value: scenario_value,
                      nightmare_context: 'ground',
                    });
                  }}
                />
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      ))(NightmareShip)}
    </Stack>
  );
};
