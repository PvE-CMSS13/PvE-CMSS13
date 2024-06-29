import { useBackend } from 'tgui/backend';
import { Box, Button, Dropdown, Section, Stack, Tabs } from 'tgui/components';
import { Window } from 'tgui/layouts';
import { BooleanLike, classes } from 'common/react';

interface ResinPanelData {
  constructions_list: ConstructionsEntry[];
  hives_list: string[];
  selected_resin: string;
  selected_hive: string;
  build_click_intercept: BooleanLike;
}

interface ConstructionsEntry {
  name: string;
  desc: string;
  image: string;
  id: string;
}

export const ResinPanel = (props, context) => {
  const { act, data } = useBackend<ResinPanelData>(context);
  const {
    constructions_list,
    hives_list,
    selected_resin,
    selected_hive,
    build_click_intercept,
  } = data;

  let compact = false;

  return (
    <Window
      width={350}
      height={15 + constructions_list.length * 80}
      title="Resin Panel"
      theme="admin">
      <Window.Content>
        <Section
          title="Resin"
          buttons={
            <Stack>
              <Stack.Item>
                <Button
                  selected={build_click_intercept}
                  content="Click Build"
                  onClick={() => act('toggle_build_click_intercept')}
                />
              </Stack.Item>
              <Stack.Item>
                <Dropdown
                  options={hives_list}
                  selected={selected_hive}
                  width="15rem"
                  onSelected={(selected_hive) => {
                    act('set_selected_hive', { selected_hive });
                  }}
                />
              </Stack.Item>
            </Stack>
          }
          scrollable
          fill>
          <Tabs vertical fluid fill>
            {constructions_list.map((item, index) => (
              <Tabs.Tab
                key={index}
                selected={item.id === selected_resin}
                onClick={() => act('set_selected_resin', { type: item.id })}>
                <Stack align="center">
                  <Stack.Item>
                    <span
                      className={classes([
                        `chooseresin${compact ? '32x32' : '64x64'}`,
                        `${item.image}${compact ? '' : '_big'}`,
                        'ChooseResin__BuildIcon',
                      ])}
                    />
                  </Stack.Item>
                  <Stack.Item grow>
                    <Box>{item.name}</Box>
                  </Stack.Item>
                </Stack>
              </Tabs.Tab>
            ))}
          </Tabs>
        </Section>
      </Window.Content>
    </Window>
  );
};
