import { useBackend } from '../backend';
import { Button, Collapsible, Divider, Section, Stack } from '../components';
import { Window } from '../layouts';

export const GameMasterRappelMenu = (props, context) => {
  const { data, act } = useBackend();

  return (
    <Window width={400} height={250}>
      <Window.Content scrollable>
        <Stack direction="column" grow>
          <GameMasterRappelPanel />
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const GameMasterRappelPanel = (props, context) => {
  const { data, act } = useBackend();

  return (
    <Section title="Rappel" mb={1}>
      <Stack direction="column">
        <Stack.Item>
          <Button
            ml={1}
            selected={data.rappel_click_intercept}
            onClick={() => {
              act('toggle_click_rappel');
            }}
          >
            Click Rappel
          </Button>
          <Button
            ml={1}
            selected={data.rappel_upp_click_intercept}
            onClick={() => {
              act('toggle_click_rappel_upp');
            }}
          >
            Click Rappel (UPP)
          </Button>
        </Stack.Item>
        {data.game_master_rappels && (
          <Stack.Item>
            <Collapsible title="Rappel Points">
              <Stack vertical>
                {data.game_master_rappels.map((val) => {
                  if (val) {
                    return (
                      <Stack.Item key={val.rappel_name}>
                        <Divider />
                        <Stack>
                          <Stack.Item align="center">
                            <Button
                              onClick={() => {
                                act('jump_to_rappel', { val });
                              }}
                            >
                              {val.rappel_name}
                            </Button>
                          </Stack.Item>
                          <Stack.Item>
                            <Button
                              color="bad"
                              onClick={() => {
                                act('remove_rappel', { val });
                              }}
                            >
                              X
                            </Button>
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    );
                  }
                })}
                <Divider />
              </Stack>
            </Collapsible>
          </Stack.Item>
        )}
      </Stack>
    </Section>
  );
};
