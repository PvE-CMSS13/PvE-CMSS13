import { auto } from '@popperjs/core';

import { useBackend } from '../backend';
import { Button, Collapsible, Section, Stack } from '../components';
import { Window } from '../layouts';

export const GameMasterFireSupportMenu = (props, context) => {
  const { act, data } = useBackend();
  return (
    <Window resizable width={'450px'}>
      <Window.Content scrollable>
        <Section
          fill
          title="Fire Support Menu"
          align="center"
          justify="center"
          height={auto}
        >
          <Stack vertical>
            <Stack.Item>
              <Button
                minWidth={'150px'}
                fontSize="15px"
                ml={1}
                selected={data.fire_support_click_intercept}
                onClick={() => {
                  act('toggle_click_fire_support');
                }}
              >
                CALL FIRE SUPPORT
              </Button>
            </Stack.Item>
          </Stack>

          <Collapsible content="Missiles">
            {data.missile_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'140px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Orbital Bombardments">
            {data.orbital_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'140px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Mortar Shells">
            {data.mortar_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'140px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Misc Ordnance">
            {data.misc_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'140px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Chemical Weapons">
            {data.chemical_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'140px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Throwables">
            {data.throwables_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'100px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>

          <Collapsible content="Flyby Ordnance">
            {data.flyby_ordnance_options.map((ordnance, i) => (
              <Button
                selected={data.selected_ordnance === ordnance}
                key={i}
                width={'100px'}
                onClick={() => {
                  act('set_selected_ordnance', { ordnance });
                }}
              >
                {ordnance}
              </Button>
            ))}
          </Collapsible>
        </Section>
      </Window.Content>
    </Window>
  );
};
